From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
	<asamymuthupa@micron.com>
Subject: [PATCH 2/3] New driver mtipx2xx submission
Date: Tue, 3 May 2011 14:19:23 -0600
Message-ID: <22A973199D2C2F46933448F6E7990A300204FB8A@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:59583 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1ECUT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 16:19:28 -0400
Received: from ntxboimbx31.micron.com (ntxboimbx31.micron.com [137.201.91.17])
	by masquerade.micron.com (8.13.6/8.13.6) with SMTP id p43KJQo2002753
	for <linux-ide@vger.kernel.org>; Tue, 3 May 2011 14:19:26 -0600
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Part 2

diff -uNr a/drivers/block/mtipx2xx/ahci.c
b/drivers/block/mtipx2xx/ahci.c
--- a/drivers/block/mtipx2xx/ahci.c	1969-12-31 17:00:00.000000000
-0700
+++ b/drivers/block/mtipx2xx/ahci.c	2011-05-03 12:57:34.000000000
-0600
@@ -0,0 +1,3895 @@
+/**********************************************************************
*******
+ *
+ * ahci.c - Handles the AHCI protocol layer of the Cyclone SSD Block
Driver
+ *   Copyright (C) 2009  Integrated Device Technology, Inc.
+ *
+ *  Changes from IDT 1.0.1 are copyright (C) 2010 Micron Technology,
Inc.
+ *
+ *  This file is part of the Cyclone SSD Block Driver, it is free
software:
+ *  you can redistribute it and/or modify it under the terms of the GNU
+ *  General Public License as published by the Free Software
Foundation;
+ *  either version 2 of the License, or (at your option) any later
version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *  if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street,
+ *  Fifth Floor, Boston,
+ *  MA 02110-1301,
+ *  USA.
+ *
+
************************************************************************
****/
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/ata.h>
+#include <linux/delay.h>
+#include <linux/hdreg.h>
+#include <linux/uaccess.h>
+#include <linux/random.h>
+#include "mtipx2xx.h"
+
+/**
+ * @file
+ * The protocol layer interfaces between the block layer and
+ * the actual hardware.
+ * This layer of the driver supports the actual protocol used to talk
to the
+ * hardware such as AHCI or NVMHCI. As already mentioned in the Block
Layer
+ * section, the Protocol Layer needs to make a number of functions
available
+ * to the BlockLayer.
+ *
+ * - ahci_init() - Called by the block layer to initialize the protocol
layer.
+ * This includes resetting and initializing the hardware, and
requesting IRQ's
+ * and enabling interrupts. This function may also perform some
rudimentary
+ * tests to ensure that the drive is operating within specified
parameters.
+ * -ahci_exit() - Called by the Block Layer to undo what was done
+ * by the init() call. It is also probably a good idea to sync the
drive.
+ * - ahci_shutdown() - Called to sync the drive before a power down.
+ * - ahci_read() - Called by the Block Layer to read a number of
+ * sectors from the device.
+ * - ahci_write() - Called by the Block Layer to write a number of
+ * sectors to the device.
+ * - ahci_hwBlkSize() - Should return the hardware block size in bytes.
+ * For Cyclone devices this is 4KB (4096 bytes).
+ * - ahci_get_capacity() - Will return the capacity of the device in
+ * 512 byte sectors.
+ * - achi_get_scatterList() - Allocate a command slot and return its
associated
+ * scatter list.
+ */
+
+#define UNU __attribute__ ((unused))
+
+#define AHCI_CMD_TBL_HDR_SZ	0x80
+#define AHCI_RX_FIS_SZ		0x100
+#define AHCI_CMD_SLOT_SZ	(MAX_COMMAND_SLOTS * 32)
+#define AHCI_CMD_TBL_SZ		(AHCI_CMD_TBL_HDR_SZ + (MAX_SG *
16))
+#define AHCI_CMD_TBL_AR_SZ	(AHCI_CMD_TBL_SZ * MAX_COMMAND_SLOTS)
+#define AHCI_PORT_PRIV_DMA_SZ \
+		(AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ + AHCI_RX_FIS_SZ)
+
+#define HBA_CAPS		0x00
+#define	HOST_CTRL		0x04
+#define HOST_IRQ_STAT	0x08
+#define PORTS_IMPL		0x0c
+#define VERSION			0x10
+#define CCCC			0x14
+#define CCCP			0x18
+#define	EML				0x1c
+#define	EMC				0x20
+#define	EX_HOST_CAP		0x24
+
+#define HOST_CAP_64		(1 << 31)
+#define	HOST_IRQ_EN		(1 << 1)
+#define	HOST_RESET		(1 << 0)
+#define HOST_HSORG	0xFC
+#define HSORG_DISABLE_SLOTGRP_INTR (1<<24)
+#define HSORG_DISABLE_SLOTGRP_PXIS (1<<16)
+#define HSORG_HWREV 0xFF00
+#define HSORG_STYLE 0x8
+#define HSORG_SLOTGROUPS 0x7
+
+#define PORT_LST_ADDR		0x00
+#define PORT_LST_ADDR_HI	0x04
+#define PORT_FIS_ADDR		0x08
+#define PORT_FIS_ADDR_HI	0x0c
+#define PORT_IRQ_STAT		0x10
+#define PORT_IRQ_EN			0x14
+#define PORT_CMD			0x18
+#define PORT_TFDATA			0x20
+#define PORT_SCR_STAT		0x28
+#define PORT_SCR_CTL		0x2c
+#define PORT_SCR_ERR		0x30
+#define PORT_SACTIVE		0x34
+#define PORT_COMMAND_ISSUE	0x38
+#define PORT_SCR_NTF		0x3c
+#define PORT_SDBV			0x7C
+
+#define PORT_CMD_ICC_ACTIVE	(1 << 28)
+#define PORT_CMD_LIST_ON	(1 << 15)
+#define PORT_CMD_FIS_RX		(1 << 4)
+#define PORT_CMD_CLO		(1 << 3)
+#define PORT_CMD_START		(1 << 0)
+#define PORT_OFFSET			0x100
+#define PORT_MEM_SIZE		0x80
+#define	RX_FIS_D2H_REG		0x40
+#define	RX_FIS_PIO			0x20
+
+#define	PORT_IRQ_COLD_PRES		(1 << 31)
+#define	PORT_IRQ_TF_ERR			(1 << 30)
+#define	PORT_IRQ_HBUS_ERR		(1 << 29)
+#define	PORT_IRQ_HBUS_DATA_ERR	(1 << 28)
+#define	PORT_IRQ_IF_ERR			(1 << 27)
+#define	PORT_IRQ_IF_NONFATAL	(1 << 26)
+#define	PORT_IRQ_OVERFLOW		(1 << 24)
+#define	PORT_IRQ_BAD_PMP		(1 << 23)
+#define	PORT_IRQ_PHYRDY			(1 << 22)
+#define	PORT_IRQ_DEV_ILCK		(1 << 7)
+#define	PORT_IRQ_CONNECT		(1 << 6)
+#define	PORT_IRQ_DPS			(1 << 5)
+#define	PORT_IRQ_UNK_FIS		(1 << 4)
+#define	PORT_IRQ_SDB_FIS		(1 << 3)
+#define	PORT_IRQ_DMAS_FIS		(1 << 2)
+#define	PORT_IRQ_PIOS_FIS		(1 << 1)
+#define	PORT_IRQ_D2H_REG_FIS	(1 << 0)
+
+#define	AHCI_CMD_WRITE			(1 << 6)
+#define	AHCI_CMD_PREFETCH		(1 << 7)
+
+#define	PORT_IRQ_FREEZE\
+	(PORT_IRQ_HBUS_ERR | PORT_IRQ_IF_ERR | PORT_IRQ_CONNECT |\
+	PORT_IRQ_PHYRDY | PORT_IRQ_UNK_FIS | PORT_IRQ_BAD_PMP)
+#define	PORT_IRQ_ERROR\
+	(PORT_IRQ_FREEZE | PORT_IRQ_TF_ERR | PORT_IRQ_HBUS_DATA_ERR |\
+	PORT_IRQ_IF_NONFATAL | PORT_IRQ_OVERFLOW)
+#define DEF_PORT_IRQ\
+	(PORT_IRQ_ERROR | PORT_IRQ_SDB_FIS | PORT_IRQ_DMAS_FIS |\
+	PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS)
+
+/* made-up magic product numbers.*/
+#define PRODUCT_UNKNOWN  0x00
+#define PRODUCT_OLDFPGA  0x11
+#define PRODUCT_ASICFPGA 0x12
+
+/*void restart_port(struct port *);*/
+
+bool resumeflag;
+
+static int exec_internal_command_polled(struct port *port,
+					void *fis,
+					int fisLen,
+					dma_addr_t buffer,
+					int bufLen,
+					u32 opts,
+					unsigned long timeout);
+
+/**
+ * @brief Display a buffer as hex.
+ *
+ * @param buffer Pointer to the buffer to be displayed.
+ * @param len Number of bytes to display.
+ *
+ * @return N/A
+ */
+static void dump_buffer(void *buffer, int len)
+{
+	int i;
+	unsigned char *data = buffer;
+
+	for (i = 0; i < len; i++) {
+		if ((i%8) == 0)
+			printk(KERN_INFO "\n");
+		printk(KERN_INFO "0x%02x ", data[i]);
+	}
+	printk(KERN_INFO "\n");
+}
+
+/**
+ * @brief Dump mmio register values.
+ *
+ * @param mmio Starting mmio register address.
+ * @param numRegs Number of 32 bit registers to dump.
+ *
+ * @return N/A
+ */
+static void UNU dump_regs(void __iomem *mmio, int numRegs)
+{
+	int n;
+	printk(KERN_INFO "%s:\n", __func__);
+	for (n = 0; n < numRegs; n++)
+		printk(KERN_INFO "0x%p = 0x%08x\n",
+				 mmio + (n * 4),
+				 readl(mmio + (n * 4)));
+}
+
+/**
+ * @brief Obtain an empty command slot.
+ *
+ * This function needs to be reentrant since it could be called
+ * at the same time on multiple CPUs. The allocation of the
+ * command slot must be atomic.
+ *
+ * @param port Pointer to the port data structure.
+ *
+ * @retval >=0 Index of command slot obtained.
+ * @retval -1 No command slots available.
+ */
+static int get_slot(struct port *port)
+{
+	int slot, ii;
+	unsigned int num_command_slots = port->dd->slot_groups * 32;
+
+	/* Try 10 times, because there is a small race here.
+	   that's ok, because it's still cheaper than a lock.*/
+
+	for (ii = 0; ii < 10; ii++) {
+		slot = find_next_zero_bit(port->allocated,
+					 num_command_slots, 1);
+		if ((slot < num_command_slots) &&
+			(!test_and_set_bit(slot, port->allocated))
+			)
+			return slot;
+	}
+	printk(KERN_ERR "get_slot() failed to get a tag.\n");
+
+
+      /*
+       * Check for the device present
+       */
+	if (check_for_surprise_removal(port->dd->pdev)) {
+
+		/* Device is not present clean the outstanding command
*/
+		command_cleanup(port->dd);
+	}
+	return FAILURE;
+}
+
+static inline void release_slot(struct port *port, int tag)
+{
+	smp_mb__before_clear_bit();
+	clear_bit(tag, port->allocated);
+	smp_mb__after_clear_bit();
+}
+
+
+
+#ifdef COMMAND_TIMEOUT
+/**
+ * @brief Called periodically to see if any read/write commands are
+ * taking too long to complete.
+ *
+ * @param data Pointer to the PORT data structure.
+ *
+ * @return N/A
+ */
+void timeout_function(unsigned long int data)
+{
+	struct port *port = (struct port *) data;
+	struct HOST_TO_DEV_FIS *fis;
+	struct COMMAND *command;
+	int tag;
+	int reset_issued = 0;
+	unsigned int num_command_slots = port->dd->slot_groups * 32;
+
+	if (resumeflag == 1) {
+		mod_timer(&port->commandTimer, jiffies +
msecs_to_jiffies(500));
+		return ;
+	}
+
+	for (tag = 0; tag < num_command_slots; tag++) {
+		/*
+		 * Do not check the internal command slot.
+		 */
+		if (tag == TAG_INTERNAL)
+			continue;
+
+		if (atomic_read(&port->commands[tag].active) &&
+		   (time_after(jiffies, port->commands[tag].compTime)))
{
+
+			unsigned int group = tag >> 5;
+			unsigned int bit = tag & 0x1f;
+
+			command = &port->commands[tag];
+			fis = (struct HOST_TO_DEV_FIS *)
command->command;
+
+			printk(KERN_WARNING "%s:timeout for command tag
%d\n",
+						 __func__, tag);
+
+			/* Clear the Completed bit; this should prevent
any
+			 * interrupt handlers from trying to retire the
+			 *  command.
+			 */
+			writel(1<<bit, port->Completed[group]);
+
+			/*
+			 * Call the async completion callback.
+			 */
+			if (likely(command->asyncCallback))
+
command->asyncCallback(command->asyncData,
+							 -EIO);
+			command->asyncCallback = NULL;
+			command->completionFunc = NULL;
+
+			/*
+			 *Unmap the DMA scatter list entries for read
and
+			 *write commands
+			 */
+			if (fis->command == ATA_CMD_FPDMA_WRITE)
+				dma_unmap_sg(&port->dd->pdev->dev,
command->sg,
+						 command->scatterEnts,
+						 DMA_TO_DEVICE);
+			else if (fis->command == ATA_CMD_FPDMA_READ)
+				dma_unmap_sg(&port->dd->pdev->dev,
command->sg,
+						 command->scatterEnts,
+						 DMA_FROM_DEVICE);
+
+			if (ISSUE_COMRESET_ON_TIMEOUT && !reset_issued)
{
+				printk(KERN_WARNING " Issuing port reset
for command timeout");
+				restart_port(port);
+				reset_issued = 1;
+			}
+
+			/*
+			 * Clear the allocated bit and active tag for
the
+			 * command.
+			 */
+			atomic_set(&port->commands[tag].active, 0);
+			release_slot(port, tag);
+
+			up(&port->commandSlot);
+		}
+	}
+
+	/*
+	 * Start the timer again.
+	 */
+	mod_timer(&port->commandTimer,
+			 jiffies +
msecs_to_jiffies(TIMEOUT_CHECK_PERIOD));
+}
+#endif
+
+/**
+ * @brief Asynchronous read completion function.
+ *
+ * This completion function is called by the driver ISR when a read
+ * command that was issued by the kernel completes. It first calls the
+ * asynchronous completion function which normally calls back into the
block
+ * layer passing the asynchronous callback data, then unmaps the
+ * scatter list associated with the completed command, and finally
+ * clears the allocated bit associated with the completed command.
+ *
+ * @param port Pointer to the port data structure.
+ * @param tag Tag of the read command that has completed.
+ * @param data Read completion data.
+ * @param status Completion status.
+ *
+ * @return N/A
+ */
+static void async_read_complete(struct port *port,
+				int tag,
+				void *data,
+				int status)
+{
+	struct driver_data *dd = data;
+	struct COMMAND *command = &port->commands[tag];
+
+	if (unlikely(status == PORT_IRQ_TF_ERR))
+		printk(KERN_WARNING "%s: Command tag %d failed due to
TFE\n",
+					__func__, tag);
+
+	/*
+	 * Call the async completion callback.
+	 */
+	if (likely(command->asyncCallback))
+		command->asyncCallback(command->asyncData, status);
+
+	command->asyncCallback = NULL;
+	command->completionFunc = NULL;
+
+	/*
+	 * Unmap the DMA scatter list entries.
+	 */
+	dma_unmap_sg(&dd->pdev->dev,
+				command->sg,
+				command->scatterEnts,
+				DMA_FROM_DEVICE);
+
+	/*
+	 * Clear the allocated and active bits for the command.
+	 */
+	atomic_set(&port->commands[tag].active, 0);
+	release_slot(port, tag);
+
+	up(&port->commandSlot);
+}
+
+/**
+ * @brief Asynchronous write completion function.
+ *
+ * This completion function is called by the driver ISR when a write
+ * command that was issued by the kernel completes. It first calls the
+ * asynchronous completion function which normally calls back into the
block
+ * layer passing the asynchronous callback data, then unmaps the
+ * scatter list associated with the completed command, and finally
+ * clears the allocated bit associated with the completed command.
+ *
+ * @param port Pointer to the port data structure.
+ * @param tag Tag of the write command that has completed.
+ * @param data Write completion data.
+ * @param status Completion status.
+ *
+ * @return N/A
+ */
+static void async_write_complete(struct port *port,
+				int tag,
+				void *data,
+				int status)
+{
+	struct driver_data *dd = data;
+	struct COMMAND *command = &port->commands[tag];
+
+	if (status == PORT_IRQ_TF_ERR)
+		printk(KERN_WARNING "%s: Command tag %d did not
completed due to TFE\n",
+			__func__, tag);
+
+	/*
+	 * Call the async completion callback.
+	 */
+	if (likely(command->asyncCallback))
+		command->asyncCallback(command->asyncData, status);
+
+	command->asyncCallback = NULL;
+	command->completionFunc = NULL;
+
+	/*
+	 * Unmap the DMA scatter list entries.
+	 */
+	dma_unmap_sg(&dd->pdev->dev,
+			command->sg,
+			command->scatterEnts,
+			DMA_TO_DEVICE);
+
+	/*
+	 *Clear the allocated and active bits for the command.
+	 */
+	atomic_set(&port->commands[tag].active, 0);
+	release_slot(port, tag);
+
+	up(&port->commandSlot);
+}
+
+/**
+ * @brief Internal command completion callback function.
+ *
+ * This function is normally called by the driver ISR when an internal
+ * command completed. This function signals the command completion by
+ * calling complete().
+ *
+ * @param port Pointer to the port data structure.
+ * @param tag Tag of the command that has completed.
+ * @param data Pointer to a completion structure.
+ * @param status Completion status.
+ *
+ * @return N/A
+ */
+static void completion(struct port *port, int tag, void *data, int
status)
+{
+	struct COMMAND *command = &port->commands[tag];
+	struct completion *waiting = data;
+	if (status == PORT_IRQ_TF_ERR)
+		printk(KERN_WARNING "%s: Command %d completed with
TFE\n",
+						__func__, tag);
+
+	command->asyncCallback = NULL;
+	command->completionFunc = NULL;
+
+	complete(waiting);
+}
+
+/**
+ * @brief Enable/disable the reception of FIS.
+ *
+ * @param port Pointer to the port data structure.
+ * @param enable New state, 1 enabled, 0 disabled.
+ *
+ * @return Previous state of the FIS, 1 enabled, 0 disabled.
+ */
+static int enable_FIS(struct port *port, int enable)
+{
+	u32 tmp;
+	/* enable FIS reception */
+	tmp = readl(port->mmio + PORT_CMD);
+	if (enable)
+		writel(tmp | PORT_CMD_FIS_RX, port->mmio + PORT_CMD);
+	else
+		writel(tmp & ~PORT_CMD_FIS_RX, port->mmio + PORT_CMD);
+
+	readl(port->mmio + PORT_CMD);
+	return (((tmp & PORT_CMD_FIS_RX) == PORT_CMD_FIS_RX));
+}
+
+/**
+ * @brief Enable/disable the DMA engine returning the previous state.
+ *
+ * @param port Pointer to the port data structure.
+ * @param enable New state, 1 enabled, 0 disabled.
+ *
+ * @return Previous state of the DMA engine, 1 enabled, 0 disabled.
+ */
+static int enable_engine(struct port *port, int enable)
+{
+	u32 tmp;
+	/* enable FIS reception */
+	tmp = readl(port->mmio + PORT_CMD);
+	if (enable)
+		writel(tmp | PORT_CMD_START, port->mmio + PORT_CMD);
+	else
+		writel(tmp & ~PORT_CMD_START, port->mmio + PORT_CMD);
+
+	readl(port->mmio + PORT_CMD);
+	return (((tmp & PORT_CMD_START) == PORT_CMD_START));
+}
+
+/**
+ * @brief Make a port active.
+ *
+ * This function enables the port DMA engine and FIS reception.
+ *
+ * @return N/A
+ */
+static void start_port(struct port *port)
+{
+	/*
+	 * Enable FIS reception.
+	 */
+	enable_FIS(port, 1);
+
+	/*
+	 * Enable the DMA engine.
+	 */
+	enable_engine(port, 1);
+}
+
+/**
+ * @brief Deinitialize a port.
+ *
+ * Deinitialize a port by disabling port interrupts, the DMA engine,
+ * and FIS reception.
+ *
+ * @param port Pointer to the port structure.
+ *
+ * @return N/A
+ */
+static void deinit_port(struct port *port)
+{
+	/*
+	 * Disable interrupts on this port.
+	 */
+	writel(0, port->mmio + PORT_IRQ_EN);
+
+	/*
+	 * Disable the DMA engine.
+	 */
+	enable_engine(port, 0);
+
+	/*
+	 * Disable FIS reception.
+	 */
+	enable_FIS(port, 0);
+}
+
+/**
+ * @brief Initialize a port.
+ *
+ * This function deinitializes the port by calling deinit_port() and
then
+ * initializes it by setting the command header and RX FIS addresses,
+ * clearing the SError register and any
+ * pending port interrupts before re-enabling the default set of
+ * port interrupts.
+ *
+ * @param port Pointer to the port structure.
+ *
+ * @return N/A
+ */
+static void init_port(struct port *port)
+{
+	int ii;
+	deinit_port(port);
+
+	/*
+	 * Program the command list base and FIS base addresses.
+	 */
+	if (readl(port->dd->mmio + HBA_CAPS) & HOST_CAP_64) {
+		writel((port->commandListDMA >> 16) >> 16,
+			 port->mmio + PORT_LST_ADDR_HI);
+		writel((port->rxFISDMA >> 16) >> 16,
+			 port->mmio + PORT_FIS_ADDR_HI);
+	}
+
+	writel(port->commandListDMA & 0xffffffff, port->mmio +
PORT_LST_ADDR);
+	writel(port->rxFISDMA & 0xffffffff, port->mmio + PORT_FIS_ADDR);
+
+
+	/*
+	 * Clear SError.
+	 */
+	writel(readl(port->mmio + PORT_SCR_ERR), port->mmio +
PORT_SCR_ERR);
+
+	/*reset the Completed registers.*/
+	for (ii = 0; ii < port->dd->slot_groups; ii++)
+		writel(0xFFFFFFFF, port->Completed[ii]);
+
+
+	/*
+	 * Clear any pending interrupts for this port.
+	 */
+	writel(readl(port->mmio + PORT_IRQ_STAT), port->mmio +
PORT_IRQ_STAT);
+
+	/*
+	 * Enable port interrupts.
+	 */
+	writel(DEF_PORT_IRQ, port->mmio + PORT_IRQ_EN);
+}
+
+/**
+ * @brief Reset the HBA (without sleeping)
+ *
+ * Just like hbaReset, except does not call sleep, so can be
+ * run from interrupt/tasklet context.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @retval 0 The reset was successful.
+ * @retval -1 The HBA Reset bit did not clear.
+ */
+int hbaReset_nosleep(struct driver_data *dd)
+{
+	unsigned long timeout;
+	mdelay(10);
+	writel(HOST_RESET, dd->mmio + HOST_CTRL);
+	timeout = jiffies + msecs_to_jiffies(1000);
+	mdelay(10);
+	while ((readl(dd->mmio + HOST_CTRL) & HOST_RESET)
+		 && time_before(jiffies, timeout))
+		mdelay(1);
+	if (readl(dd->mmio + HOST_CTRL) & HOST_RESET)
+		return -1;
+	return 0;
+}
+
+/**
+ * @brief Restart a port after a Task File Error.
+ *
+ * This function is called to restart a port after a Task File Error
+ * has been detected.
+ *
+ * @param port Pointer to the port data structure.
+ *
+ * @return N/A
+ */
+void restart_port(struct port *port)
+{
+	int didReset = 0;
+	unsigned long timeout;
+	struct HOST_TO_DEV_FIS fis;
+
+	/*
+	 * Disable the DMA engine.
+	 */
+	enable_engine(port, 0);
+
+	/*
+	 * Wait for PxCMD.CR == 0
+	 */
+	timeout = jiffies + msecs_to_jiffies(500);
+	while ((readl(port->mmio + PORT_CMD) & PORT_CMD_LIST_ON)
+		 && time_before(jiffies, timeout))
+		;
+
+	if (readl(port->mmio + PORT_CMD) & PORT_CMD_LIST_ON) {
+		printk(KERN_WARNING "%s:PxCMD.CR not clear do HBA
reset\n",
+				 __func__);
+		/*Issue HBA reset here.  Don't do any sleeping because
we're
+		 *in interrupt context!
+		 */
+		if (hbaReset_nosleep(port->dd))
+			printk(KERN_ERR "HBA Reset escalation
failed.\n");
+
+		/*
+		 * no longer any need to do comreset, just exit.
+		*/
+		return;
+	}
+	/*
+	 * Check if a COMRESET is required.
+	 */
+	/*	if (readl(port->mmio + PORT_TFDATA) & (ATA_BUSY |
ATA_DRQ))*/
+	{
+		printk(KERN_INFO "%s: Issuing COMRESET\n", __func__);
+		/*
+		 * Set PxSCTL.DET
+		 */
+		writel(readl(port->mmio + PORT_SCR_CTL) |
+				 1, port->mmio + PORT_SCR_CTL);
+		readl(port->mmio + PORT_SCR_CTL);
+
+		/*
+		 * Wait at least 1ms
+		 */
+		timeout = jiffies + msecs_to_jiffies(1);
+		while (time_before(jiffies, timeout))
+			;
+
+		/*
+		 * Clear PxSCTL.DET
+		 */
+		writel(readl(port->mmio + PORT_SCR_CTL) & ~1,
+				 port->mmio + PORT_SCR_CTL);
+		readl(port->mmio + PORT_SCR_CTL);
+
+		/*
+		 * Wait for bit 0 of PORT_SCR_STS to be set.
+		 */
+		timeout = jiffies + msecs_to_jiffies(500);
+		while (((readl(port->mmio + PORT_SCR_STAT) & 0x01) == 0)
+				 && time_before(jiffies, timeout))
+			;
+
+		if ((readl(port->mmio + PORT_SCR_STAT) & 0x01) == 0)
+			printk(KERN_WARNING "%s:PORT_SCR_STAT bit 1 not
set\n",
+						__func__);
+
+		didReset = 1;
+	}
+
+	/*
+	 * Clear SError, the PxSERR.DIAG.x should be set so clear it.
+	 */
+	writel(readl(port->mmio + PORT_SCR_ERR), port->mmio +
PORT_SCR_ERR);
+
+	/*
+	 * Enable the DMA engine.
+	 */
+	enable_engine(port, 1);
+
+	/*
+	 * Issue Read Log Ext.
+	 */
+	if (!didReset) {
+
+		/*
+		 * Build the FIS.
+		 */
+		memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+		fis.type		= 0x27;
+		fis.opts		= 1 << 7;
+		fis.command		= ATA_CMD_READ_LOG_EXT;
+		fis.sectCount	= 1;
+		fis.LBALow		= ATA_LOG_SATA_NCQ;
+		fis.device		= ATA_DEVICE_OBS;
+
+		memset(port->sectorBuffer, 0, ATA_SECT_SIZE);
+
+		printk(KERN_INFO "%s:executing read logpage 10h to clear
err\n"
+				 , __func__);
+		/*
+		 * Execute the command.
+		 */
+		/*
+			if (exec_internal_command_polled(port,
+				&fis,
+				5,
+				port->sectorBufferDMA,
+				ATA_SECT_SIZE,
+				0, 100))
+		*/
+		if (exec_internal_command_polled(port,
+						 &fis,
+						 5,
+						 port->sectorBufferDMA,
+						 ATA_SECT_SIZE,
+						 (1<<10), 100))
+			printk(KERN_WARNING "%s: Error issuing
ReadLogExt\n",
+						 __func__);
+
+		{
+			int n;
+			unsigned char *buf =
+				(unsigned char *) port->sectorBuffer;
+			for (n = 0; n < 13; n++)
+				printk(KERN_INFO "%s: 0x%02x\n",
+							 __func__,
buf[n]);
+		}
+	}
+
+}
+
+static inline void issue_command(struct port *, int);
+
+static void print_tags(struct driver_data *dd,
+				char *msg,
+				unsigned long *tagbits)
+{
+	unsigned int tag, count = 0;
+	for (tag = 0; tag < (dd->slot_groups)*32; tag++) {
+		if (test_bit(tag, tagbits))
+			count++;
+	}
+	if (count)
+		printk(KERN_INFO "%s [%i tags]\n", msg, count);
+}
+
+/**
+ * @brief Handle a Task File Error.
+ *
+ * @param dd Pointer to the DRIVER_DATA structure.
+ *
+ * @retval 0
+ */
+static int handleTFE(struct driver_data *dd)
+{
+	int group;
+	int tag;
+	int bit;
+	struct port *port;
+	struct COMMAND  *command;
+	u32 completed;
+	/* used to accumulate tag bits for log messages*/
+	unsigned long tagaccum[SLOTBITS_IN_LONGS];
+
+	/*
+	 * Grab the lock to prevent any more commands from
+	 * being issued.printk(KERN_WARNING "%s: Error issuing
ReadLogExt
+	 */
+	/*
+	 *	FIXME: Spinlock CILock went away!
+	 *	Need something to take its place.
+	*/
+	printk(KERN_WARNING "Taskfile error!\n");
+
+	port = dd->port;
+#ifdef COMMAND_TIMEOUT
+	/*
+	 * Stop the timer to prevent command timeouts.
+	 */
+	del_timer(&port->commandTimer);
+#endif
+
+	/*
+	* Loop through all the groups.
+	*/
+	for (group = 0; group < dd->slot_groups; group++) {
+		completed = readl(port->Completed[group]);
+		/* clear completed status register in the hardware.*/
+		writel(completed, port->Completed[group]);
+		/* clear the tag accumulator*/
+		memset(tagaccum, 0, SLOTBITS_IN_LONGS * sizeof(long));
+
+		/*
+		 * Process successfully completed commands.
+		 */
+		for (bit = 0; bit < 32 && completed; bit++) {
+			if (completed & (1<<bit)) {
+				tag = (group << 5) + bit;
+				/*
+				 * Do not process the internal command
slot.
+				 */
+				if (tag == TAG_INTERNAL)
+					continue;
+
+				command = &port->commands[tag];
+				if (likely(command->completionFunc)) {
+					set_bit(tag, tagaccum);
+					command->completionFunc(port,
+						 tag,
+
command->completionData,
+						 0);
+				} else {
+					printk(KERN_WARNING
"%s:completion function isNULL, tag=%d\n",
+
__func__, tag);
+				       /*
+					* Check for the device present
+					*/
+					if (check_for_surprise_removal(
+							dd->pdev)) {
+						/*
+						* Device is not present
+						* clean the outstanding
+						* command
+						*/
+						command_cleanup(dd);
+						/*
+						 * Stop executing
further
+						 * process in driver
+						*/
+						return SUCCESS;
+					}
+
+				}
+			}
+		}
+	}
+	print_tags(dd, "TFE tags completed:", tagaccum);
+
+
+	if (ISSUE_COMRESET_ON_TFE) {
+		mdelay(20);
+		restart_port(port);
+	}
+
+	/*
+	 * If software failure emulation is enabled. If the error.
+	 */
+	if (dd->makeItFail & 0x03) {
+		struct HOST_TO_DEV_FIS	*fis =
+		(struct HOST_TO_DEV_FIS *)port->commands[
+					dd->makeItFailTag].command;
+
+		fis->LBALow   = (dd->makeItFailStart & 0xff);
+		fis->LBAMid   = (dd->makeItFailStart >> 8) & 0xff;
+		fis->LBAHi    = (dd->makeItFailStart >> 16) & 0xff;
+		fis->LBALowEx = (dd->makeItFailStart >> 24) & 0xff;
+		fis->LBAMidEx = (dd->makeItFailStart >> 32) & 0xff;
+		fis->LBAHiEx  = (dd->makeItFailStart >> 40) & 0xff;
+	} else {
+		/*
+		 * Read log page 10h to determine cause of error.
+		 */
+	}
+
+	/* clear the tag accumulator*/
+	memset(tagaccum, 0, SLOTBITS_IN_LONGS * sizeof(long));
+
+	/*
+	 * Loop through all the groups.
+	 */
+	for (group = 0; group < dd->slot_groups; group++) {
+		for (bit = 0; bit < 32; bit++) {
+			int reissue = 0;
+			tag = (group << 5) + bit;
+			/*
+			 * If the active bit is set re-issue the
command.
+			 */
+			if (atomic_read(&port->commands[tag].active)) {
+				/* Should  re-issue an internal/ioctl
command*/
+				if (tag == TAG_INTERNAL) {
+					if (REISSUE_INT_COMMANDS_ON_ERR
+					 &&
port->internalCommandInProgress)
+						reissue = 1;
+				} else {
+				/* Should we re-issue an NCQ command?*/
+					if (REISSUE_NCQ_COMMANDS_ON_ERR)
+						reissue = 1;
+				}
+
+				if (reissue) {
+					/* First check if this command
has
+					 *  exceeded its retries.
+					 *  */
+					if
(!port->commands[tag].retries--) {
+						/* command will be
retired with
+						 * a failure code
below.*/
+						reissue = 0;
+					} else {
+						/*printk(KERN_INFO "%s:
+						 * Reissue tag %d\n",
+						 * __func__, tag);*/
+						set_bit(tag, tagaccum);
+
+#ifdef COMMAND_TIMEOUT
+						/*
+						 * Update the timeout
value.
+						 */
+
port->commands[tag].compTime =
+						jiffies +
msecs_to_jiffies(
+						NCQ_COMMAND_TIMEOUT_MS);
+#endif
+						/*
+						 * Re-issue the command.
+						 */
+						issue_command(port,
tag);
+					}
+				}
+				/* Here we retire a command that will
not be
+				 * reissued.*/
+				if (!reissue) {
+					printk(KERN_WARNING "retiring
tag %d\n",
+								 tag);
+
atomic_set(&port->commands[tag].active,
+							 0);
+
+				if (port->commands[tag].completionFunc)
+
port->commands[tag].completionFunc(
+					port,
+					tag,
+
port->commands[tag].completionData,
+					PORT_IRQ_TF_ERR);
+				else
+					printk(KERN_WARNING "%s: tag %d
completion function is NULL\n",
+							__func__, tag);
+				}
+			}
+		}
+	}
+	print_tags(dd, "TFE tags reissued:", tagaccum);
+
+#ifdef COMMAND_TIMEOUT
+	mod_timer(&port->commandTimer,
+		 jiffies + msecs_to_jiffies(TIMEOUT_CHECK_PERIOD));
+#endif
+
+	/*
+	 * Allow commands to continue.
+	 */
+	/*spin_unlock(&dd->CILock);*/
+
+	return 0;
+}
+
+/**
+ * @brief Handle a Set Device Bits interrupt.
+ *
+ * This function performs retirement of completed commands.
+ *
+ * @param dd Pointer to the DRIVER_DATA structure.
+ *
+ * @retval 0
+ */
+static void process_SDBF(struct driver_data *dd)
+{
+	struct port  *port = dd->port;
+	int group, tag, bit;
+	u32 completed;
+	struct COMMAND *command;
+
+	for (group = 0; group < dd->slot_groups; group++) {
+		completed = readl(port->Completed[group]);
+
+		/* clear completed status register in the hardware.*/
+		writel(completed, port->Completed[group]);
+
+		/*
+		 * Process completed commands.
+		 */
+		for (bit = 0; bit < 32 && completed; bit++) {
+			if (completed & 0x01) {
+				tag = (group << 5) | bit;
+				/*
+				 * Do not process the internal command
slot.
+				 */
+				if (likely(tag != TAG_INTERNAL)) {
+					command = &port->commands[tag];
+					if
(likely(command->completionFunc))
+						command->completionFunc(
+						port,
+						 tag,
+
command->completionData,
+						 0);
+					else{
+						printk(KERN_WARNING "%s:
While"
+						" processing
PORT_IRQ_SDB_FIS,"
+						" completion function is
NULL,"
+						" tag = %d!\n",
__func__, tag);
+
+						/*
+						*Check for the device
present
+						*/
+						if
(check_for_surprise_removal(
+
dd->pdev)) {
+							/*
+							 * Device is not
+							 * present clean
+							 * the
outstanding
+							 * command
+							*/
+
command_cleanup(dd);
+							return ;
+						}
+
+					}
+				}
+			}
+			completed >>= 1;
+		}
+	}
+}
+
+
+
+
+
+#if USE_TASKLET
+static void tasklet_proc(unsigned long data)
+#else
+static inline irqreturn_t process_IRQ(struct driver_data *data)
+#endif
+{
+	struct driver_data *dd = (struct driver_data *) data;
+	struct port *port = dd->port;
+	u32 hbaStat;
+	int portStat;
+	int oldIrqBugWorkaround = 0;
+#if !USE_TASKLET
+	int rv = IRQ_NONE;
+#endif
+
+	if (dd->product_type == PRODUCT_OLDFPGA)
+		oldIrqBugWorkaround = 1;
+
+	hbaStat = readl(dd->mmio + HOST_IRQ_STAT);
+	if (hbaStat) {
+#if !USE_TASKLET
+		rv = IRQ_HANDLED;
+#endif
+		if (oldIrqBugWorkaround) {
+			/* Acknowledge the interrupt status on the
HBA.*/
+			writel(hbaStat, dd->mmio + HOST_IRQ_STAT);
+		}
+
+		/* Acknowledge the interrupt status on the port.*/
+		portStat = readl(port->mmio + PORT_IRQ_STAT);
+		writel(portStat, port->mmio + PORT_IRQ_STAT);
+		/*printk("PORT_IRQ_STAT = 0x%08x\n", portStat);*/
+
+		if (likely(portStat & PORT_IRQ_SDB_FIS))
+			process_SDBF(dd);
+
+
+		if (unlikely(portStat & (PORT_IRQ_TF_ERR |
PORT_IRQ_IF_ERR))) {
+			if (unlikely(portStat & PORT_IRQ_IF_ERR))
+				printk(KERN_WARNING
"PORT_IRQ_IF_ERR.\n");
+
+
+			/*
+			* Check for the device presence
+			*/
+			if (check_for_surprise_removal(dd->pdev)) {
+				/*
+				* Device is not presence clean the
+				* outstanding command
+				*/
+				command_cleanup(dd);
+				/*
+				* Stop executing further process in
driver
+				*/
+
+				return ;
+			}
+
+			handleTFE(dd);
+		}
+		if (unlikely(portStat & PORT_IRQ_CONNECT)) {
+			printk(KERN_INFO "%s: Clearing PxSERR.DIAG.x\n",
+						 __func__);
+			/*
+			 * Clear PxSERR.DIAG.x
+			 */
+			writel((1<<26), port->mmio + PORT_SCR_ERR);
+		}
+
+		if (unlikely(portStat & PORT_IRQ_PHYRDY)) {
+			printk(KERN_INFO "%s: Clearing PxSERR.DIAG.n\n",
+					 __func__);
+			/*
+			 * Clear PxSERR.DIAG.n
+			 */
+			writel((1<<16), port->mmio + PORT_SCR_ERR);
+		}
+
+		if (unlikely(portStat & PORT_IRQ_DMAS_FIS))
+			printk(KERN_WARNING "Got DMA FIS\n");
+
+		/*if (unlikely(portStat & PORT_IRQ_DPS))
+		printk(KERN_WARNING "Got DPS IRQ, CI=%x\n",
+		readl(port->CommandIssue[0]));
+		*/
+		if (unlikely(portStat & PORT_IRQ_PIOS_FIS)) {
+			/*printk(KERN_WARNING "Got PIOS FIS IRQ,
+			 *  CI=%x\n", readl(port->CommandIssue[0]));*/
+			if (port->internalCommandInProgress) {
+				if (!(readl(
+					port->CommandIssue[TAG_INDEX(
+						TAG_INTERNAL)])
+						 & (1 <<
TAG_BIT(TAG_INTERNAL)
+						))) {
+					if (port->commands[
+
TAG_INTERNAL].completionFunc)
+						port->commands[
+
TAG_INTERNAL].completionFunc(
+						port,
+						TAG_INTERNAL,
+						port->commands[
+
TAG_INTERNAL].completionData,
+						0);
+					else
+						printk(KERN_WARNING
"%s:"
+							"internal"
+							" command
completion"
+							" function is
NULL,"
+							" tag = %d!\n",
+							 __func__,
+							TAG_INTERNAL);
+				}
+			} else
+				printk(KERN_WARNING "Hmmm, got PIOS_FIS
but no"
+							"internal"
+							" command is"
+							"
outstanding!\n");
+		}
+
+		if (unlikely(portStat & PORT_IRQ_D2H_REG_FIS)) {
+			if (port->internalCommandInProgress) {
+				if
(port->commands[TAG_INTERNAL].completionFunc)
+					port->commands[
+					TAG_INTERNAL].completionFunc(
+					port,
+					TAG_INTERNAL,
+					port->commands[
+					TAG_INTERNAL].completionData,
+					 0);
+				else
+					printk(KERN_WARNING "%s: While"
+						"processing"
+						"PORT_IRQ_D2H_REG_FIS,"
+						"completion function is"
+						"NULL, tag = %d!\n",
+						 __func__,
TAG_INTERNAL);
+			} else {
+				printk(KERN_WARNING "Hmmm, got
D2H_REG_FIS"
+						" but no internal"
+						" command is
outstanding!\n");
+				dump_buffer(dd->port->rxFIS +
RX_FIS_D2H_REG,
+						 20);
+			}
+		}
+		if (unlikely(portStat & PORT_IRQ_HBUS_ERR))
+			printk(KERN_WARNING "PORT_IRQ_HBUS_ERR
unhandled.\n");
+
+		if (unlikely(portStat & PORT_IRQ_UNK_FIS))
+			printk(KERN_WARNING "PORT_IRQ_UNK_FIS
unhandled.\n");
+
+		if (unlikely(portStat & PORT_IRQ_BAD_PMP))
+			printk(KERN_WARNING "PORT_IRQ_BAD_PMP
unhandled.\n");
+
+		if (unlikely(portStat & PORT_IRQ_HBUS_DATA_ERR))
+			printk(KERN_WARNING "PORT_IRQ_HBUS_DATA_ERR
unhandled.\n");
+
+		if (unlikely(portStat & PORT_IRQ_IF_NONFATAL))
+			printk(KERN_WARNING "PORT_IRQ_IF_NONFATAL
unhandled.\n");
+
+		if (unlikely(portStat & PORT_IRQ_OVERFLOW))
+			printk(KERN_WARNING "PORT_IRQ_OVERFLOW
unhandled.\n");
+
+	}
+
+	if (!oldIrqBugWorkaround) {
+		/*Acknowledge the interrupt status on the HBA.*/
+		writel(hbaStat, dd->mmio + HOST_IRQ_STAT);
+	}
+
+#if USE_TASKLET
+
+#else
+	return rv;
+#endif
+}
+
+/**
+ * @brief HBA interrupt subroutine.
+ *
+ * @param irq IRQ number.
+ * @param dev_instance Pointer to the driver data structure.
+ *
+ * @retval IRQ_HANDLED A HBA interrupt was pending and handled.
+ * @retval IRQ_NONE This interrupt was not for the HBA.
+ */
+static irqreturn_t irq_handler(int irq, void *dev_instance)
+{
+	struct driver_data *dd = dev_instance;
+	atomic_inc(&dd->statistics.interrupts);
+#if USE_TASKLET
+	tasklet_schedule(&dd->tasklet);
+	return IRQ_HANDLED;
+#else
+	return process_IRQ(dd);
+#endif
+}
+
+/**
+ * @brief Dump the contents of a command header.
+ *
+ * @param hdr Pointer to the command header to dump.
+ * @param index Index of the command header to dump.
+ *
+ * @return N/A
+ */
+static void UNU dump_CmdHdr(void *hdr, int index)
+{
+	unsigned int *ptr = (unsigned int *) hdr;
+
+	printk(KERN_INFO "Command Header %d:\n", index);
+	printk(KERN_INFO "dw0: 0x%08x\n", *ptr++);
+	printk(KERN_INFO "dw1: 0x%08x\n", *ptr++);
+	printk(KERN_INFO "dw2: 0x%08x\n", *ptr++);
+	printk(KERN_INFO "dw3: 0x%08x\n", *ptr++);
+	printk(KERN_INFO "dw4: 0x%08x\n", *ptr++);
+	printk(KERN_INFO "dw5: 0x%08x\n", *ptr++);
+	printk(KERN_INFO "dw6: 0x%08x\n", *ptr++);
+	printk(KERN_INFO "dw7: 0x%08x\n\n", *ptr++);
+}
+
+static void issue_non_NCQ_command(struct port *port, int tag)
+{
+	atomic_set(&port->commands[tag].active, 1);
+	writel(1 << TAG_BIT(tag), port->CommandIssue[TAG_INDEX(tag)]);
+}
+
+
+/**
+ * @brief Issue a command to the hardware.
+ *
+ * Set the appropriate bit in the SActive and Command Issue hardware
+ * registers, causing hardware command processing to begin.
+ *
+ * @param port Pointer to the port structure.
+ * @param tag The tag of the command to be issued.
+ *
+ * @return N/A
+ */
+static inline void issue_command(struct port *port, int tag)
+{
+	unsigned long flags = 0;
+	int need_lock = 0;
+
+	atomic_set(&port->commands[tag].active, 1);
+
+	/* "cmdIssueLock": workaround for a bug involving parallel
command
+	 * issue.
+	* if two cpus interleave these two steps the hardware will hang.
+	*/
+	if (port->dd->product_type == PRODUCT_ASICFPGA)
+		need_lock = 1;
+	if (need_lock)
+		spin_lock_irqsave(&port->cmdIssueLock, flags);
+
+	writel((1 << TAG_BIT(tag)), port->SActive[TAG_INDEX(tag)]);
+	writel(1 << TAG_BIT(tag), port->CommandIssue[TAG_INDEX(tag)]);
+
+	if (need_lock)
+		spin_unlock_irqrestore(&port->cmdIssueLock, flags);
+}
+
+/**
+ * @brief Execute an internal command and wait for the completion.
+ *
+ * When calling this function the writer portion of the internalSem
+ * should be held.
+ *
+ * @param port Pointer to the port data structure.
+ * @param fis Pointer to the FIS that describes the command.
+ * @param fisLen Length in WORDS of the FIS.
+ * @param buffer DMA accessible for command data.
+ * @param bufLen Length, in bytes, of the data buffer.
+ * @param timeout Time in ms that this function will wait for the
command
+ * to complete.
+ *
+ * @retval 0 Command completed successfully.
+ * @retval -EFAULT The buffer address is not correctly aligned.
+ * @retval -EAGAIN An internal command is already in progress.
+ * @retval -EBUSY A response was not received within the timeout
period.
+ */
+static int exec_internal_command(struct port *port,
+				void *fis,
+				int fisLen,
+				dma_addr_t buffer,
+				int bufLen,
+				unsigned long timeout)
+{
+	unsigned int active;
+	struct COMMAND_SG	*commandSG;
+	DECLARE_COMPLETION_ONSTACK(wait);
+	unsigned long to;
+
+	port->internalCommandInProgress = 1;
+
+	/*
+	 * Make sure the buffer is 8 byte aligned. This is
+	 * Cyclone specific.
+	 */
+	if (buffer & 0x00000007) {
+		printk(KERN_ERR "Hold it! The SG buffer is not 8 byte
aligned!!!\n");
+		return -EFAULT;
+	}
+
+	/*
+	 * Wait for all other commands to complete or a timeout.
+	 */
+	to = jiffies + msecs_to_jiffies(5000);
+	do {
+		int n;
+
+		/*
+		 * Ignore SActive bit 0 of array element 0.
+		 * This bit will always be set
+		 */
+		active = readl(port->SActive[0]) & 0xfffffffe;
+		for (n = 1; n < port->dd->slot_groups; n++)
+			active |= readl(port->SActive[n]);
+
+		if (!active)
+			break;
+
+		msleep(20);
+	} while (time_before(jiffies, to));
+
+	if (active)
+		printk(KERN_WARNING "%s timeout wait for commands to
complete\n",
+					__func__);
+
+	/*
+	 * Copy the command to the command table.
+	 */
+	memcpy(port->commands[TAG_INTERNAL].command, fis, fisLen*4);
+
+	port->commands[TAG_INTERNAL].commandHeader->opts =
cpu_to_le32(fisLen);
+	/*
+	 * Populate the SG list.
+	 */
+	if (bufLen) {
+		commandSG = port->commands[TAG_INTERNAL].command +
+				 AHCI_CMD_TBL_HDR_SZ;
+		commandSG->info	= cpu_to_le32(((bufLen-1) & 0x3fffff));
+		commandSG->dba		= cpu_to_le32(buffer &
0xffffffff);
+		commandSG->dbaUpper = cpu_to_le32((buffer >> 16) >> 16);
+		port->commands[TAG_INTERNAL].commandHeader->opts |=
cpu_to_le32(
+								(1 <<
16));
+	}
+	port->commands[TAG_INTERNAL].commandHeader->byteCount = 0;
+
+	/*
+	 * Set the completion function and data for the command.
+	 */
+	port->commands[TAG_INTERNAL].completionData = &wait;
+	port->commands[TAG_INTERNAL].completionFunc = completion;
+
+	/*
+	 * Issue the command to the hardware.
+	 */
+	issue_non_NCQ_command(port, TAG_INTERNAL);
+
+	/*
+	 * Wait for the command to complete or timeout.
+	 */
+	if (wait_for_completion_timeout(
+				&wait,
+				msecs_to_jiffies(timeout)) == 0) {
+		port->internalCommandInProgress = 0;
+		printk(KERN_ERR "Timeout waiting for internal command to
complete\n");
+		return -EBUSY;
+	}
+	if (readl(port->CommandIssue[TAG_INDEX(TAG_INTERNAL)])
+			 & (1 << TAG_BIT(TAG_INTERNAL)))
+		printk(KERN_ERR "ERROR: retiring internal command but CI
is still 1.\n");
+
+	/* Mark the slot as inactive.*/
+	atomic_set(&port->commands[TAG_INTERNAL].active, 0);
+	port->internalCommandInProgress = 0;
+	return 0;
+}
+
+/**
+ * @brief Execute an internal command and wait for the completion.
+ *
+ * @param port Pointer to the port data structure.
+ * @param fis Pointer to the FIS that describes the command.
+ * @param fisLen Length in WORDS of the FIS.
+ * @param buffer DMA accessible for command data.
+ * @param bufLen Length, in bytes, of the data buffer.
+ * @param opts Command header options, excluding the FIS length and the
number of PRD entries.
+ * @param timeout Time in ms to wait for the command to complete.
+ *
+ * @retval 0 Command completed successfully.
+ * @retval -EFAULT The buffer address is not correctly aligned.
+ * @retval -EAGAIN An internal command is already in progress.
+ */
+static int exec_internal_command_polled(struct port *port,
+					void *fis,
+					int fisLen,
+					dma_addr_t buffer,
+					int bufLen,
+					u32 opts,
+					unsigned long timeout)
+{
+	struct COMMAND_SG	*commandSG;
+	int rv = 0;
+
+	/*
+	 * Make sure the buffer is 8 byte aligned. This is
+	 * Cyclone specific.
+	 */
+	if (buffer & 0x00000007) {
+		printk(KERN_ERR "Hold it! The SG buffer is not 8 byte
aligned!!!\n");
+		return -EFAULT;
+	}
+
+	/*
+	 * Only one internal command should be running at a time.
+	 */
+	if (test_and_set_bit(TAG_INTERNAL, port->allocated)) {
+		printk(KERN_ERR "Internal command already active!\n");
+		return -EAGAIN;
+	}
+
+	/*
+	 * Copy the command to the command table.
+	 */
+	memcpy(port->commands[TAG_INTERNAL].command, fis, fisLen*4);
+
+	/*
+	 * Populate the SG list.
+	 */
+	port->commands[TAG_INTERNAL].commandHeader->opts =
+		 cpu_to_le32(opts | fisLen);
+	if (bufLen) {
+		commandSG = port->commands[TAG_INTERNAL].command +
+					 AHCI_CMD_TBL_HDR_SZ;
+		commandSG->info = cpu_to_le32((bufLen-1) & 0x3fffff);
+		commandSG->dba		= cpu_to_le32(buffer &
0xffffffff);
+		commandSG->dbaUpper =
+			cpu_to_le32((buffer >> 16) >> 16);
+		port->commands[TAG_INTERNAL].commandHeader->opts |=
+					cpu_to_le32((1 << 16));
+	}
+
+	/*
+	 * Populate the command header.
+	 */
+	port->commands[TAG_INTERNAL].commandHeader->byteCount = 0;
+
+	/*
+	 * Set the completion function and data for the command.
+	 */
+	port->commands[TAG_INTERNAL].completionData = NULL;
+	port->commands[TAG_INTERNAL].completionFunc = NULL;
+
+	/*
+	 * Issue the command to the hardware.
+	 */
+	writel(1 << TAG_BIT(TAG_INTERNAL),
+		port->CommandIssue[TAG_INDEX(TAG_INTERNAL)]);
+	timeout = jiffies + msecs_to_jiffies(timeout);
+	while ((readl(port->CommandIssue[TAG_INDEX(TAG_INTERNAL)])
+			& (1 << TAG_BIT(TAG_INTERNAL)))
+			 && time_before(jiffies, timeout))
+		;
+
+	if (readl(port->CommandIssue[TAG_INDEX(TAG_INTERNAL)])
+			& (1 << TAG_BIT(TAG_INTERNAL))) {
+		printk(KERN_ERR "Internal command did not complete!\n");
+		rv = -1;
+	}
+	/*
+	 * Clear the allocated and active bits for the internal command.
+	 */
+	atomic_set(&port->commands[TAG_INTERNAL].active, 0);
+	release_slot(port, TAG_INTERNAL);
+
+	return rv;
+}
+
+/**
+ * @brief Byte-swap ATA ID strings.
+ *
+ * ATA identify data contains strings in byte-swapped 16-bit words.
+ * They must be swapped (on all architectures) to be usable as C
strings.
+ * This function swaps bytes in-place.
+ *
+ * @param buf The buffer location of the string
+ * @param len The number of bytes to swap
+ *
+ * @return N/A
+ */
+static void ata_swap_string(u16 *buf, unsigned int len)
+{
+	char *cbuf = (char *)buf;
+	unsigned int ii = 0;
+
+	while (ii < len) {
+		char tmp = cbuf[ii];
+		cbuf[ii] = cbuf[ii+1];
+		cbuf[ii+1] = tmp;
+		ii += 2;
+	}
+}
+
+
+/**
+ * @brief Request the device identity information.
+ *
+ * If a user space buffer is not specified, i.e. is NULL, the
+ * identify information is still read from the drive and placed
+ * into the identify data buffer (@e port->identify) in the port data
structure.
+ * When the identify buffer contains valid identify information @e
+ * port->identifyValid is non-zero.
+ *
+ * @param port Pointer to the port structure.
+ * @param userBuffer A user space buffer where the identify data should
be copied.
+ *
+ * @retval 0 Command completed successfully.
+ * @retval -EFAULT An error occurred while coping data to the user
space buffer.
+ * @retval -1 Command failed.
+ */
+static int get_identify(struct port *port, void __user *userBuffer)
+{
+	int rv = 0;
+	struct HOST_TO_DEV_FIS	fis;
+
+	down_write(&port->dd->internalSem);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= ATA_CMD_ID_ATA;
+
+	/*
+	 * Set the identify information as invalid.
+	 */
+	clear_bit(0, (unsigned long *) &port->identifyValid);
+
+	/*
+	 * Clear the identify information.
+	 */
+	memset(port->identify, 0, sizeof(u16) * ATA_ID_WORDS);
+
+	/*
+	 * Execute the command.
+	 */
+	if (exec_internal_command(port,
+				&fis,
+				5,
+				port->identifyDMA,
+				sizeof(u16) * ATA_ID_WORDS,
+				INTERNAL_COMMAND_TIMEOUT_MS)
+				< 0) {
+		rv = -1;
+		goto out;
+	}
+	/* Perform any necessary byte-swapping.  Yes, the kernel does in
fact
+	 * perform field-sensitive swapping on the string fields.
+	 *See the kernel use of ata_id_string() for proof of this.
+	 */
+#ifdef __LITTLE_ENDIAN
+	ata_swap_string(port->identify + 27, 40);  /* model string*/
+	ata_swap_string(port->identify + 23, 8);   /* firmware string*/
+	ata_swap_string(port->identify + 10, 20);  /* serial# string*/
+#else
+	swap_buf_le16(port->identify, ATA_ID_WORDS);
+#endif
+
+	/*
+	 * Set the identify buffer as valid.
+	 */
+	set_bit(0, (unsigned long *) &port->identifyValid);
+
+	if (userBuffer) {
+		if (copy_to_user(
+				userBuffer,
+				port->identify,
+				ATA_ID_WORDS * sizeof(u16))
+			) {
+			rv = -EFAULT;
+			goto out;
+		}
+	}
+
+out:
+	up_write(&port->dd->internalSem);
+	return rv;
+}
+
+/**
+ * @brief Issue a software reset to the HBA.
+ *
+ * This function issues a software reset to the device by first sending
+ * a FIS with the reset bit set, waiting 500ms, and then sending a FIS
+ *with the reset bit cleared.
+ *
+ * @param port Pointer to the port data structure.
+ *
+ * @retval 0 The reset completed successfullt.
+ * @retval -1 An error occurred executing one of the reset commands.
+ *
+ * @note This function is untested.
+ */
+static int UNU software_reset(struct port *port)
+{
+	struct HOST_TO_DEV_FIS	fis;
+	u32 opts = 0;
+
+	memset(port->rxFIS, 0, AHCI_RX_FIS_SZ);
+	enable_engine(port, 0);
+	msleep(500);
+	enable_engine(port, 1);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.control		= ATA_SRST;
+
+	/*
+	 * Execute the command.
+	 * The C & R bits need to be set in the command header.
+	 */
+	opts = 1 << 8 | 1 << 10;
+	if (exec_internal_command_polled(port,
+					&fis,
+					 5,
+					 0, 0,
+					 opts,
+					 INTERNAL_COMMAND_TIMEOUT_MS) <
0) {
+		printk(KERN_ERR "%s: timeout setting ATA_SRST\n",
__func__);
+		return -1;
+	}
+
+	msleep(500);
+
+	fis.control	= 0;
+	opts = 0;
+	/*
+	 * Execute the command.
+	 */
+	if (exec_internal_command_polled(port,
+					 &fis,
+					 5,
+					 0,
+					 0,
+					 opts,
+					 INTERNAL_COMMAND_TIMEOUT_MS) <
0) {
+		printk(KERN_ERR "%s: timeout clearing ATA_SRST\n",
__func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int UNU set_feature(struct port *port,
+		 unsigned char enable,
+		 unsigned char feature
+		 )
+{
+	int rv;
+	struct HOST_TO_DEV_FIS	fis;
+
+	down_write(&port->dd->internalSem);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= ATA_CMD_SET_FEATURES;
+	fis.features	= enable;
+	fis.sectCount	= feature;
+
+	/*
+	 * Execute the command.
+	 */
+	rv = exec_internal_command(port,
+				 &fis,
+				 5,
+				 0,
+				 0,
+				 INTERNAL_COMMAND_TIMEOUT_MS);
+
+	up_write(&port->dd->internalSem);
+	return rv;
+}
+
+static int UNU set_max_address(struct port *port, sector_t sectors)
+{
+	int rv;
+	struct HOST_TO_DEV_FIS	fis;
+
+	down_write(&port->dd->internalSem);
+
+	sectors--;
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= ATA_CMD_SET_MAX_EXT;
+	fis.device		= ATA_LBA;
+
+	fis.LBALow		= (sectors >> 0) & 0xff;
+	fis.LBAMid		= (sectors >> 8) & 0xff;
+	fis.LBAHi		= (sectors >> 16) & 0xff;
+	fis.LBALowEx	= (sectors >> 24) & 0xff;
+	fis.LBAMidEx	= (sectors >> 32) & 0xff;
+	fis.LBAHiEx		= (sectors >> 40) & 0xff;
+
+	/*
+	 * Execute the command.
+	 */
+	rv = exec_internal_command(port,
+				 &fis,
+				 5,
+				 0,
+				 0,
+				 INTERNAL_COMMAND_TIMEOUT_MS);
+
+	up_write(&port->dd->internalSem);
+	return rv;
+}
+
+/**
+ * @brief Issue an ATA_CMD_READ_NATIVE_MAX_EXT command to the device.
+ *
+ * @param port Pointer to the port structure.
+ *
+ * @return Returns the number of 512 byte sectors on success else all
f's
+ */
+static sector_t read_max_address(struct port *port)
+{
+	struct HOST_TO_DEV_FIS	fis;
+	struct HOST_TO_DEV_FIS	*rxFIS;
+	sector_t sectors;
+
+	down_write(&port->dd->internalSem);
+
+	memset(port->rxFIS, 0, AHCI_RX_FIS_SZ);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= ATA_CMD_READ_NATIVE_MAX_EXT;
+	fis.device		= ATA_LBA;
+	/*
+	 * Execute the command.
+	 */
+	if (exec_internal_command(port,
+				 &fis,
+				 5,
+				 0,
+				 0,
+				 INTERNAL_COMMAND_TIMEOUT_MS) < 0) {
+		up_write(&port->dd->internalSem);
+		return -1;
+	}
+
+	rxFIS = port->rxFIS + RX_FIS_D2H_REG;
+
+	sectors = rxFIS->LBALow;
+	sectors |= rxFIS->LBAMid << 8;
+	sectors |= rxFIS->LBAHi << 16;
+	sectors |= rxFIS->LBALowEx << 24;
+	sectors |= (sector_t) rxFIS->LBAMidEx << 32;
+	sectors |= (sector_t) rxFIS->LBAHiEx << 40;
+
+	up_write(&port->dd->internalSem);
+	return sectors+1;
+}
+
+/**
+ * @brief Issue a standby immediate command to the device.
+ *
+ * @param port Pointer to the port structure.
+ *
+ * @retval 0 Command was executed successfully.
+ * @retval -1 An error occurred while executing the command.
+ */
+static int standby_immediate(struct port *port)
+{
+	int rv;
+	struct HOST_TO_DEV_FIS	fis;
+
+	down_write(&port->dd->internalSem);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= ATA_CMD_STANDBYNOW1;
+
+	/*
+	 * Execute the command.  Use a 10-second timeout for large
drives.
+	 */
+	rv = exec_internal_command(port, &fis, 5, 0, 0, 10000);
+
+	up_write(&port->dd->internalSem);
+	return rv;
+}
+
+/**
+ * @brief Write an internal drive config register
+ *
+ * @param port Pointer to the port structure.
+ * @param addr Config register address
+ * @param data Config register data
+ *
+ * @retval 0 Command was executed successfully.
+ * @retval -1 An error occurred while executing the command.
+ */
+
+
+/**
+ * @brief Read data from a log page.
+ *
+ * @param port Pointer to the port data structure.
+ * @param page Number of the page to read.
+ * @param buffer Location where read data is placed.
+ * @param sectors The number of sectors to read from the log.
+ *
+ * @retval 0 The log page was read successfully.
+ * @retval -1 A timeout occurred waiting for this command to complete.
+ */
+static int UNU read_logpage(struct port *port,
+				u8 page,
+				dma_addr_t buffer,
+				int sectors)
+{
+	int rv;
+	struct HOST_TO_DEV_FIS	fis;
+	unsigned int *dump = (unsigned int *) &fis;
+	down_write(&port->dd->internalSem);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= ATA_CMD_READ_LOG_EXT;
+	fis.sectCount	= sectors & 0xff;
+	fis.secCountEx	= (sectors >> 8) & 0xff;
+	fis.LBALow		= page;
+	fis.LBAMid		= 0;
+	fis.device		= ATA_DEVICE_OBS;
+
+	printk(KERN_INFO "0x%08x\n", dump[0]);
+	printk(KERN_INFO "0x%08x\n", dump[1]);
+	printk(KERN_INFO "0x%08x\n", dump[2]);
+	printk(KERN_INFO "0x%08x\n", dump[3]);
+	printk(KERN_INFO "0x%08x\n", dump[4]);
+
+	/*
+	 * Execute the command.
+	 */
+	rv = exec_internal_command(port,
+				&fis,
+				 5,
+				 buffer,
+				 sectors * ATA_SECT_SIZE,
+				 INTERNAL_COMMAND_TIMEOUT_MS);
+
+	dump = (port->rxFIS + RX_FIS_D2H_REG);
+	printk(KERN_INFO "Outputs:\n");
+	printk(KERN_INFO "0x%08x\n", dump[0]);
+	printk(KERN_INFO "0x%08x\n", dump[1]);
+	printk(KERN_INFO "0x%08x\n", dump[2]);
+	printk(KERN_INFO "0x%08x\n", dump[3]);
+	printk(KERN_INFO "0x%08x\n", dump[4]);
+
+	up_write(&port->dd->internalSem);
+	return rv;
+}
+
+/**
+ * @brief Get the drive capacity.
+ *
+ * @param port Pointer to the port structure.
+ * @param sectors Pointer to the variable that will receive the sector
count.
+ *
+ * @retval 1 Capacity was returned successfully.
+ * @retval 0 The identify information is invalid.
+ */
+static int getCapacity(struct port *port, sector_t *sectors)
+{
+	u64 total, raw0, raw1, raw2, raw3;
+	raw0 = port->identify[100];
+	raw1 = port->identify[101];
+	raw2 = port->identify[102];
+	raw3 = port->identify[103];
+	total = raw0 | raw1<<16 | raw2<<32 | raw3<<48;
+	*sectors = total;
+	return port->identifyValid;
+}
+
+/**
+ * @brief Reset the HBA.
+ *
+ * Resets the HBA by setting the HBA Reset bit in the Global
+ * HBA Control register. After setting the HBA Reset bit the
+ * function waits for 1 second before reading the HBA Reset
+ * bit to make sure it has cleared. If HBA Reset is not clear
+ * an error is returned.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @retval 0 The reset was successful.
+ * @retval -1 The HBA Reset bit did not clear.
+ */
+static int hba_reset(struct driver_data *dd)
+{
+	deinit_port(dd->port);
+
+	/*
+	 * Set the reset bit.
+	 */
+	writel(HOST_RESET, dd->mmio + HOST_CTRL);
+
+	/*
+	 * Flush.
+	 */
+	readl(dd->mmio + HOST_CTRL);
+
+	/*
+	 * Wait for reset to clear.
+	 */
+	ssleep(1);
+
+	/*
+	 * Check the bit has cleared.
+	 */
+	if (readl(dd->mmio + HOST_CTRL) & HOST_RESET)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * @brief Display the identify command data.
+ *
+ * @param port Pointer to the port data structure.
+ *
+ * @retval 0 The identify information is valid and has been displayed.
+ * @retval -1 The identify information is invalid.
+ */
+static int dump_identify(struct port *port)
+{
+	sector_t sectors;
+	char cbuf[42];
+
+	if (!port->identifyValid)
+		return -1;
+	/* note string length is +1 to allow for null.*/
+	strlcpy(cbuf, (char *)(port->identify+10), 21);
+	printk(KERN_INFO "Serial No.: %s\n", cbuf);
+
+	strlcpy(cbuf, (char *)(port->identify+23), 9);
+	printk(KERN_INFO "Firmware Ver.: %s\n", cbuf);
+
+	strlcpy(cbuf, (char *)(port->identify+27), 41);
+	printk(KERN_INFO "Model: %s\n", cbuf);
+
+	if (getCapacity(port, &sectors))
+		printk(KERN_INFO "Capacity: %llu sectors (%lluMB)\n",
+					 (u64)sectors,
+					 ((u64)sectors) * ATA_SECT_SIZE
>> 20);
+
+	return 0;
+}
+
+/**
+ * @brief Map the commands scatter list into the command table.
+ *
+ * @param command Pointer to the command.
+ * @param nents Number of scatter list entries.
+ *
+ * @return This function always returns 0.
+ */
+static inline int fill_command_SG(struct COMMAND *command, int nents)
+{
+	int n;
+	struct COMMAND_SG *commandSG = command->command +
AHCI_CMD_TBL_HDR_SZ;
+	struct scatterlist *sg = command->sg;
+
+	for (n = 0; n < nents; n++) {
+		unsigned int dma_len = sg_dma_len(sg);
+		if (dma_len > 0x400000)
+			printk(KERN_ERR "Error: DMA segment length
truncated!\n");
+		commandSG->info = cpu_to_le32((dma_len-1) & 0x3fffff);
+#if (BITS_PER_LONG == 64)
+		*((unsigned long *) &commandSG->dba) =
+			 cpu_to_le64(sg_dma_address(sg));
+#else
+		commandSG->dba	= cpu_to_le32(sg_dma_address(sg));
+		commandSG->dbaUpper	=
+			 cpu_to_le32((sg_dma_address(sg) >> 16) >> 16);
+#endif
+		commandSG++;
+		sg++;
+	}
+
+	return 0;
+}
+
+/**
+ * @brief Execute a drive command.
+ *
+ * @retval 0 The command completed successfully.
+ * @retval -1 An error occurred while executing the command.
+ */
+int exec_drive_task(struct port *port, u8 *command)
+{
+	struct HOST_TO_DEV_FIS	fis;
+	struct HOST_TO_DEV_FIS *reply = (port->rxFIS + RX_FIS_D2H_REG);
+
+	/*
+	 * Lock the internal command semaphore.
+	 */
+	down_write(&port->dd->internalSem);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= command[0];
+	fis.features	= command[1];
+	fis.sectCount	= command[2];
+	fis.sector		= command[3];
+	fis.cylLow		= command[4];
+	fis.cylHi		= command[5];
+	fis.device		= command[6] & ~0x10; /* Clear the dev
bit*/
+
+
+	printk(KERN_INFO "User Command %s: command = 0x%x, feature =
0x%x, nsector = 0x%x, sector = 0x%x, lcyl = 0x%x, hcyl = 0x%x, select =
0x%x\n",
+			__func__,
+			command[0],
+			command[1],
+			command[2],
+			command[3],
+			command[4],
+			command[5],
+			command[6]
+			);
+
+	/*
+	 * Execute the command.
+	 */
+	if (exec_internal_command(port,
+				 &fis,
+				 5,
+				 0,
+				 0, IOCTL_COMMAND_TIMEOUT_MS) < 0) {
+		up_write(&port->dd->internalSem);
+		return -1;
+	}
+
+	command[0] = reply->command; /* Status*/
+	command[1] = reply->features; /* Error*/
+	command[4] = reply->cylLow;
+	command[5] = reply->cylHi;
+
+	printk(KERN_INFO "Completion Status from devices %s: Status =
0x%x, Error = 0x%x , CylLow = 0x%x CylHi = 0x%x\n",
+				__func__,
+			  command[0],
+			  command[1],
+			  command[4],
+			  command[5]);
+
+	up_write(&port->dd->internalSem);
+	return 0;
+}
+
+/**
+ * @brief Execute a drive command.
+ *
+ * @param port Pointer to the port data structure.
+ * @param command Pointer to the user specified command parameters.
+ * @param userBuffer Pointer to the user space buffer where read sector
data should be copied.
+ *
+ * @retval 0 The command completed successfully.
+ * @retval -EFAULT An error occurred while copying the completion data
to the user space buffer.
+ * @retval -1 An error occurred while executing the command.
+ */
+int exec_drive_command(struct port *port, u8 *command, void __user
*userBuffer)
+{
+	struct HOST_TO_DEV_FIS	fis;
+	struct HOST_TO_DEV_FIS *reply = (port->rxFIS + RX_FIS_D2H_REG);
+
+	/*
+	 * Lock the internal command semaphore.
+	 */
+	down_write(&port->dd->internalSem);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= command[0];
+	fis.features	= command[2];
+	fis.sectCount	= command[3];
+	if (fis.command == WIN_SMART) {
+		fis.sector	= command[1];
+		fis.cylLow	= 0x4f;
+		fis.cylHi	= 0xc2;
+	}
+
+
+	printk(KERN_INFO " UserCommand %s: command = 0x%x, sector =
0x%x, features = 0x%x, sectCount = 0x%x\n",
+			__func__,
+			command[0],
+			command[1],
+			command[2],
+			command[3]);
+
+	memset(port->sectorBuffer, 0x00, ATA_SECT_SIZE);
+
+	/*
+	 * Execute the command.
+	 */
+	if (exec_internal_command(port,
+				&fis,
+				 5,
+				 port->sectorBufferDMA,
+				 (command[3] != 0) ? ATA_SECT_SIZE : 0,
+				 IOCTL_COMMAND_TIMEOUT_MS)
+				 < 0) {
+		up_write(&port->dd->internalSem);
+		return -1;
+	}
+
+	/*
+	 * Collect the completion status.
+	 */
+	command[0] = reply->command; /* Status*/
+	command[1] = reply->features; /* Error*/
+	command[2] = command[3];
+
+	printk(KERN_INFO "Completion Status from devices %s: Status =
0x%x, Error = 0x%x , Command = 0x%x\n",
+				__func__,
+				command[0],
+				command[1],
+				command[2]);
+
+	if (userBuffer && command[3]) {
+		if (copy_to_user(userBuffer,
+				 port->sectorBuffer,
+				 ATA_SECT_SIZE * command[3])) {
+			up_write(&port->dd->internalSem);
+			return -EFAULT;
+		}
+	}
+
+	up_write(&port->dd->internalSem);
+	return 0;
+}
+
+/**
+ *  @brief Execute returns 1 if the command is one that
+ *   always has a single sector payload.
+ *
+ *  @param command passed to the device to perform the certain event.
+ *  @param features passed to the device to perform the certain event.
+ *  @returns 1 if the command is one that always has a single sector
payload,
+ *   regardless of the value in the Sector Count field.
+ *
+ */
+
+unsigned int implicit_sector(unsigned char command, unsigned char
features)
+{
+	unsigned int rv = 0;
+
+	/* this is a list of commands that have an implicit sector count
of 1.*/
+	switch (command) {
+	case 0xF1:
+	case 0xF2:
+	case 0xF3:
+	case 0xF4:
+	case 0xF5:
+	case 0xF6:
+	case 0xE4:
+	case 0xE8:
+		rv = 1;
+		break;
+	case 0xF9:
+		if (features == 0x03)
+			rv = 1;
+		break;
+	case 0xB0:
+		if ((features == 0xD0) || (features == 0xD1))
+			rv = 1;
+		break;
+	case 0xB1:
+		if ((features == 0xC2) || (features == 0xC3))
+			rv = 1;
+		break;
+	}
+	return rv;
+}
+/* Borrows liberally from ide_taskfile_ioctl()
+ *
+ */
+
+static int exec_drive_taskfile(struct driver_data *dd, unsigned long
arg)
+{
+	struct HOST_TO_DEV_FIS	fis;
+	struct HOST_TO_DEV_FIS *reply;
+
+	ide_task_request_t *req_task;
+	u8 *outbuf = NULL;
+	u8 *inbuf = NULL;
+	dma_addr_t outbuf_dma = (dma_addr_t)NULL;
+	dma_addr_t inbuf_dma = (dma_addr_t)NULL;
+	dma_addr_t dma_buffer = (dma_addr_t)NULL;
+	int err = 0;
+	int tasksize = sizeof(struct ide_task_request_s);
+	unsigned int taskin = 0;
+	unsigned int taskout = 0;
+	u8 nsect = 0;
+	char __user *buf = (char __user *)arg;
+	unsigned int timeout = IOCTL_COMMAND_TIMEOUT_MS;
+	unsigned int force_single_sector;
+	unsigned int transfer_size;
+
+
+	req_task = kzalloc(tasksize, GFP_KERNEL);
+	if (req_task == NULL)
+		return -ENOMEM;
+	if (copy_from_user(req_task, buf, tasksize)) {
+		kfree(req_task);
+		return -EFAULT;
+	}
+
+	/* we don't support the extended register set.*/
+	/*if (req_task->in_flags.b.data_hob ||
+			req_task->in_flags.b.sector_hob ||
+			req_task->in_flags.b.nsector_hob ||
+			req_task->in_flags.b.lcyl_hob) {
+		err = -EINVAL;
+		goto abort;
+	}*/
+
+	taskout = req_task->out_size;
+	taskin = req_task->in_size;
+	/* 130560 = 512 * 0xFF*/
+	if (taskin > 130560 || taskout > 130560) {
+		err = -EINVAL;
+		goto abort;
+	}
+
+	if (taskout) {
+		int outtotal = tasksize;
+		outbuf = kzalloc(taskout, GFP_KERNEL);
+		if (outbuf == NULL) {
+			err = -ENOMEM;
+			goto abort;
+		}
+		if (copy_from_user(outbuf, buf + outtotal, taskout)) {
+			err = -EFAULT;
+			goto abort;
+		}
+		outbuf_dma = pci_map_single(dd->pdev,
+					 outbuf,
+					 taskout,
+					 DMA_TO_DEVICE);
+		if (outbuf_dma == (dma_addr_t)NULL) {
+			err = -ENOMEM;
+			goto abort;
+		}
+		dma_buffer = outbuf_dma;
+	}
+
+	if (taskin) {
+		int intotal = tasksize + taskout;
+		inbuf = kzalloc(taskin, GFP_KERNEL);
+		if (inbuf == NULL) {
+			err = -ENOMEM;
+			goto abort;
+		}
+		/* FIXME: why are we copying the "in" buffer from the
user?
+		* keep for now because this is how kernel ATA does it.
+		*/
+		if (copy_from_user(inbuf, buf + intotal, taskin)) {
+			err = -EFAULT;
+			goto abort;
+		}
+		inbuf_dma = pci_map_single(dd->pdev,
+					 inbuf,
+					 taskin, DMA_FROM_DEVICE);
+		if (inbuf_dma == (dma_addr_t)NULL) {
+			err = -ENOMEM;
+			goto abort;
+		}
+		dma_buffer = inbuf_dma;
+	}
+
+	/* This driver only supports PIO and non-data commands
+	 * from this ioctl.*/
+	switch (req_task->data_phase) {
+	case TASKFILE_OUT:
+		nsect = taskout / ATA_SECT_SIZE;
+		reply = (dd->port->rxFIS + RX_FIS_PIO);
+		break;
+	case TASKFILE_IN:
+		reply = (dd->port->rxFIS + RX_FIS_PIO);
+		break;
+	case TASKFILE_NO_DATA:
+		reply = (dd->port->rxFIS + RX_FIS_D2H_REG);
+		break;
+	default:
+		err = -EINVAL;
+		goto abort;
+	}
+
+	/*
+	 * Lock the internal command semaphore.
+	 */
+	down_write(&dd->internalSem);
+
+	/*
+	 * Build the FIS.
+	 */
+	memset(&fis, 0, sizeof(struct HOST_TO_DEV_FIS));
+
+	fis.type		= 0x27;
+	fis.opts		= 1 << 7;
+	fis.command		= req_task->io_ports[7];
+	fis.features	= req_task->io_ports[1];
+	fis.sectCount	= req_task->io_ports[2];
+	fis.LBALow		= req_task->io_ports[3];
+	fis.LBAMid		= req_task->io_ports[4];
+	fis.LBAHi		= req_task->io_ports[5];
+	 /* Clear the dev bit*/
+	fis.device		= req_task->io_ports[6] & ~0x10;
+
+	if ((req_task->in_flags.all == 0) && (req_task->out_flags.all &
1)) {
+		req_task->in_flags.all	=
+			IDE_TASKFILE_STD_IN_FLAGS |
(IDE_HOB_STD_IN_FLAGS << 8);
+		fis.LBALowEx		= req_task->hob_ports[3];
+		fis.LBAMidEx		= req_task->hob_ports[4];
+		fis.LBAHiEx			=
req_task->hob_ports[5];
+		fis.featuresEx		= req_task->hob_ports[1];
+		fis.secCountEx		= req_task->hob_ports[2];
+
+	} else {
+		req_task->in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
+	}
+
+	force_single_sector = implicit_sector(fis.command,
fis.features);
+
+	if ((taskin || taskout) && (!fis.sectCount)) {
+		if (nsect)
+			fis.sectCount = nsect;
+		else {
+				if (!force_single_sector) {
+					printk(KERN_WARNING "%s:
requested data movement but sectCount is 0!\n",
+
__func__);
+					up_write(&dd->internalSem);
+					err = -EINVAL;
+					goto abort;
+				}
+
+		}
+	}
+
+	printk(KERN_INFO "taskfile command = 0x%x, feature = 0x%x,
nsector = 0x%x, sector/lbal = 0x%x, lcyl/lbam = 0x%x, hcyl/lbah = 0x%x,
head/device = 0x%x\n",
+			fis.command,
+			fis.features,
+			fis.sectCount,
+			fis.LBALow,
+			fis.LBAMid, fis.LBAHi, fis.device);
+
+	/* If the command is Download Microcode increase the timeout to
+	 * 60 seconds.*/
+	if (fis.command == 0x92)
+		timeout = 60000;
+
+	/* If the command is Security Erase Unit increase the timeout to
+	 * 4 minutes.*/
+	if (fis.command == 0xF4)
+		timeout = 240000;
+
+	/* If the command is standby immediate increase the timeout to
+	 * 10 seconds.*/
+	if (fis.command == 0xE0)
+		timeout = 10000;
+
+	/* If the command is vendor unquie command the timeout to
+	 * 2 minutes.*/
+	if (fis.command == 0xF7)
+		timeout = 10000;
+
+	if (fis.command == 0xFA)
+		timeout = 10000;
+
+	/* Determine the correct transfer size.*/
+	if (force_single_sector)
+		transfer_size = ATA_SECT_SIZE;
+	else
+		transfer_size = ATA_SECT_SIZE * fis.sectCount;
+
+
+	/* Execute the command.*/
+	if (exec_internal_command(dd->port,
+				 &fis,
+				 5,
+				 dma_buffer,
+				 transfer_size, timeout) < 0) {
+		up_write(&dd->internalSem);
+		err = -EIO;
+		goto abort;
+	}
+
+	/* reclaim the DMA buffers.*/
+	if (inbuf_dma)
+		pci_unmap_single(dd->pdev, inbuf_dma, taskin,
DMA_FROM_DEVICE);
+	if (outbuf_dma)
+		pci_unmap_single(dd->pdev, outbuf_dma, taskout,
DMA_TO_DEVICE);
+	inbuf_dma = outbuf_dma = (dma_addr_t)NULL;
+
+	/* return the ATA registers to the caller.*/
+	req_task->io_ports[7] =	reply->command;
+	req_task->io_ports[1] = reply->features;
+	req_task->io_ports[2] = reply->sectCount;
+	req_task->io_ports[3] = reply->LBALow;
+	req_task->io_ports[4] = reply->LBAMid;
+	req_task->io_ports[5] = reply->LBAHi;
+	req_task->io_ports[6] = reply->device;
+
+	if (req_task->out_flags.all & 1)  {
+
+		req_task->hob_ports[3] = reply->LBALowEx;
+		req_task->hob_ports[4] = reply->LBAMidEx;
+		req_task->hob_ports[5] = reply->LBAHiEx;
+		req_task->hob_ports[1] = reply->featuresEx;
+		req_task->hob_ports[2] = reply->secCountEx;
+	}
+
+	printk(KERN_INFO "Completion Status from devices %s: Status =
0x%x,"
+			"Error = 0x%x , sectCount = 0x%x, Lbalow = 0x%x
,"
+			"LbaMid = 0x%x, LbaHi = 0x%x, Device = 0x%x\n",
+				__func__,
+				req_task->io_ports[7],
+				req_task->io_ports[1],
+				req_task->io_ports[2],
+				req_task->io_ports[3],
+				req_task->io_ports[4],
+				req_task->io_ports[5],
+				req_task->io_ports[6]);
+
+	up_write(&dd->internalSem);
+
+	/* FIXME: why are we copying "out" data back to the user?
+	* keep for now because this is how kernel ATA does it.
+	*/
+	if (copy_to_user(buf, req_task, tasksize)) {
+		err = -EFAULT;
+		goto abort;
+	}
+	if (taskout) {
+		int outtotal = tasksize;
+		if (copy_to_user(buf + outtotal, outbuf, taskout)) {
+			err = -EFAULT;
+			goto abort;
+		}
+	}
+	if (taskin) {
+		int intotal = tasksize + taskout;
+		if (copy_to_user(buf + intotal, inbuf, taskin)) {
+			err = -EFAULT;
+			goto abort;
+		}
+	}
+abort:
+	if (inbuf_dma)
+		pci_unmap_single(dd->pdev, inbuf_dma, taskin,
DMA_FROM_DEVICE);
+	if (outbuf_dma)
+		pci_unmap_single(dd->pdev, outbuf_dma, taskout,
DMA_TO_DEVICE);
+	kfree(req_task);
+	kfree(outbuf);
+	kfree(inbuf);
+
+	return err;
+}
+
+
+/**
+ * @brief Handle IOCTL calls from the Block Layer.
+ *
+ * This function is called by the Block Layer when it receives an IOCTL
command
+ * that it does not understand. If the IOCTL command is not supported
+ * this function returns -ENOTTY.
+ *
+ * @param dd Pointer to the driver data structure.
+ * @param cmd IOCTL command passed from the Block Layer.
+ * @param arg IOCTL argument passed from the Block Layer.
+ *
+ * @retval 0 The IOCTL completed successfully.
+ * @retval -ENOTTY The specified command is not supported.
+ * @retval -EFAULT An error occurred copying data to a user space
buffer.
+ * @retval -EIO An error occurred while executing the command.
+ */
+int ahci_ioctl(struct driver_data *dd, unsigned int cmd, unsigned long
arg)
+{
+	switch (cmd) {
+	case HDIO_GET_IDENTITY:
+		if (get_identify(dd->port, (void __user *) arg) < 0) {
+			printk(KERN_ERR "%s: Unable to read identity\n",
+						__func__);
+			return -EIO;
+		}
+
+		break;
+	case HDIO_DRIVE_CMD:
+	{
+		u8 driveCommand[4];
+
+		/*
+		 * Copy the user command info to our buffer.
+		 */
+		if (copy_from_user(driveCommand,
+					 (void __user *) arg,
+					 sizeof(driveCommand)))
+			return -EFAULT;
+
+		/*
+		 * Execute the drive command.
+		 */
+		if (exec_drive_command(dd->port,
+					 driveCommand,
+					 (void __user *) (arg+4)))
+			return -EIO;
+
+		/*
+		 * Copy the status back to the users buffer.
+		 */
+		if (copy_to_user((void __user *) arg,
+					 driveCommand,
+					 sizeof(driveCommand)))
+			return -EFAULT;
+
+		break;
+	}
+	case HDIO_DRIVE_TASK:
+	{
+		u8 driveCommand[7];
+
+		/*
+		 * Copy the user command info to our buffer.
+		 */
+		if (copy_from_user(driveCommand,
+					 (void __user *) arg,
+					 sizeof(driveCommand)))
+			return -EFAULT;
+
+		/*
+		 * Execute the drive command.
+		 */
+		if (exec_drive_task(dd->port, driveCommand))
+			return -EIO;
+
+		/*
+		 * Copy the status back to the users buffer.
+		 */
+		if (copy_to_user((void __user *) arg,
+					 driveCommand,
+					 sizeof(driveCommand)))
+			return -EFAULT;
+
+		break;
+	}
+	case HDIO_DRIVE_TASKFILE:
+		return exec_drive_taskfile(dd, arg);
+
+	default:
+		printk(KERN_WARNING "%s: unsupported IOCTL 0x%x\n",
+					 __func__, cmd);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * @brief Asynchronous write.
+ *
+ * This function is called by the block layer to issue a write command
+ * to the device. Upon completion of the write the callback function
will
+ * be called with the data parameter passed as the callback data.
+ *
+ * @param dd Pointer to the driver data structure.
+ * @param start First sector to write.
+ * @param nsect Number of sectors to write.
+ * @param nents Number of entries in scatter list for the write
command.
+ * @param tag The tag of this write command.
+ * @param callback Pointer to the function that should be called
+ * when the write completes.
+ * @param data Callback data passed to the callback function
+ * when the write completes.
+ * @param barrier If non-zero, this command must be completed
+ * before issuing any other commands.
+ *
+ * @return This function always returns 0.
+ */
+int ahci_write(struct driver_data *dd,
+				sector_t start,
+				int nsect,
+				int nents,
+				int tag,
+				void *callback,
+				void *data,
+				int barrier)
+{
+	struct HOST_TO_DEV_FIS	*fis;
+	struct port *port = dd->port;
+	struct COMMAND *command = &port->commands[tag];
+
+	/*
+	 * Map the scatter list for DMA access.
+	 */
+	nents = dma_map_sg(&dd->pdev->dev, command->sg, nents,
DMA_TO_DEVICE);
+
+	/*
+	 * Number of sg entries.
+	 */
+	command->scatterEnts = nents;
+
+	/*
+	 * The number of retries for this command before it is
+	 * reported as a failure to the upper layers.
+	 */
+	command->retries = MAX_RETRIES;
+
+	fis = command->command;
+	/*
+	 * Build the FIS.
+	 */
+	fis->type		= 0x27;
+	fis->opts		= 1 << 7;
+	fis->command	= ATA_CMD_FPDMA_WRITE;
+
+	/*
+	 * This is used to inject errors into the read flow.
+	 */
+	if (unlikely(dd->makeItFail & 0x02)) {
+		spin_lock(&dd->makeItFailLock);
+		if (unlikely(dd->randomWriteCount-- == 0)) {
+			dd->makeItFailTag = tag;
+			dd->makeItFailStart = start;
+			get_random_bytes(&dd->randomWriteCount,
+					 sizeof(dd->randomWriteCount));
+			dd->randomWriteCount &= 0xfffff;
+			printk(KERN_INFO "%s: Random write count =
%d\n",
+					 __func__,
+					 dd->randomWriteCount);
+			printk(KERN_INFO "%s: Generating error for tag
%d\n",
+						 __func__, tag);
+			/*
+			 * Set start to an invalid value.
+			 */
+			start = (sector_t) -1;
+		}
+		spin_unlock(&dd->makeItFailLock);
+	}
+
+	*((unsigned int *) &fis->LBALow) = (start & 0xffffff);
+	*((unsigned int *) &fis->LBALowEx) = ((start >> 24) & 0xffffff);
+
+	fis->device		= 1 << 6;
+	if (barrier)
+		fis->device |= FUA_BIT;
+
+	fis->features	= nsect & 0xff;
+	fis->featuresEx	= (nsect >> 8) & 0xff;
+
+	fis->sectCount	= ((tag << 3) | (tag >> 5));
+	fis->secCountEx	= 0;
+	fis->control	= 0;
+	fis->res2		= 0;
+	fis->res3		= 0;
+
+	fill_command_SG(command, nents);
+
+	/*
+	 * Populate the command header.
+	 */
+	command->commandHeader->opts = cpu_to_le32(
+			(nents << 16) | 5 | AHCI_CMD_WRITE |
AHCI_CMD_PREFETCH
+			);
+	command->commandHeader->byteCount = 0;
+
+	/*
+	 * Set the completion function and data for the command.
+	 */
+	command->completionData = dd;
+	command->completionFunc = async_write_complete;
+
+	command->asyncData = data;
+	command->asyncCallback = callback;
+
+	/*
+	 * Lock used to prevent this command from being issued
+	 * if an internal command is in progress.
+	 */
+	down_read(&port->dd->internalSem);
+
+	atomic_inc(&dd->statistics.writes);
+
+	/*
+	 * Issue the command to the hardware.
+	 */
+	issue_command(port, tag);
+
+#ifdef COMMAND_TIMEOUT
+	/* Set the command's timeout value.*/
+	port->commands[tag].compTime = jiffies + msecs_to_jiffies(
+
NCQ_COMMAND_TIMEOUT_MS
+							);
+#endif
+
+	up_read(&port->dd->internalSem);
+
+	return 0;
+}
+
+/**
+ * @brief Asynchronous read.
+ *
+ * This function is called by the block layer to issue a read command
+ * to the device. Upon completion of the read the callback function
will
+ * be called with the data parameter passed as the callback data.
+ *
+ * @param dd Pointer to the driver data structure.
+ * @param start First sector to read.
+ * @param nsect Number of sectors to read.
+ * @param nents Number of entries in scatter list for the read command.
+ * @param tag The tag of this read command.
+ * @param callback Pointer to the function that should be called
+ * when the read completes.
+ * @param data Callback data passed to the callback function
+ * when the read completes.
+ * @param barrier If non-zero, this command must be completed before
+ * issuing any other commands.
+ *
+ * @return This function always returns 0.
+ */
+int ahci_read(struct driver_data *dd,
+			sector_t start,
+			int nsect,
+			int nents,
+			int tag,
+			void *callback,
+			void *data,
+			int barrier)
+{
+	struct HOST_TO_DEV_FIS	*fis;
+	struct port *port = dd->port;
+	struct COMMAND *command = &port->commands[tag];
+
+	/*
+	 * Map the scatter list for DMA access.
+	 */
+	nents = dma_map_sg(&dd->pdev->dev, command->sg, nents,
DMA_FROM_DEVICE);
+
+	/*
+	 * Number of sg entries.
+	 */
+	command->scatterEnts = nents;
+
+	/*
+	 * The number of retries for this command before it is
+	 * reported as a failure to the upper layers.
+	 */
+	command->retries = MAX_RETRIES;
+
+	fis = command->command;
+	/*
+	 * Build the FIS.
+	 */
+	fis->type		= 0x27;
+	fis->opts		= 1 << 7;
+	fis->command	= ATA_CMD_FPDMA_READ;
+
+	/*
+	 * This is used to inject errors into the read flow.
+	 */
+	if (unlikely(dd->makeItFail & 0x01)) {
+		spin_lock(&dd->makeItFailLock);
+		if (unlikely(dd->randomReadCount-- == 0)) {
+			dd->makeItFailTag = tag;
+			dd->makeItFailStart = start;
+			get_random_bytes(&dd->randomReadCount,
+				 sizeof(dd->randomReadCount));
+			dd->randomReadCount &= 0xffffff;
+			printk(KERN_INFO "%s: Random read count = %d\n",
+					__func__,
+					dd->randomReadCount);
+			printk(KERN_INFO "%s: Generating error for tag
%d\n",
+							__func__, tag);
+			/*
+			 * Set start to an invalid value.
+			 */
+			start = (sector_t) -1;
+		}
+		spin_unlock(&dd->makeItFailLock);
+	}
+
+	*((unsigned int *) &fis->LBALow) = (start & 0xffffff);
+	*((unsigned int *) &fis->LBALowEx) = ((start >> 24) & 0xffffff);
+
+	/*
+	 * This has to be done after writing the start lower bytes.
+	 */
+	fis->device		= 1 << 6;
+	if (barrier)
+		fis->device |= FUA_BIT;
+
+	fis->features	= nsect & 0xff;
+	fis->featuresEx	= (nsect >> 8) & 0xff;
+
+	fis->sectCount	= ((tag << 3) | (tag >> 5));
+	fis->secCountEx	= 0;
+	fis->control	= 0;
+	fis->res2		= 0;
+	fis->res3		= 0;
+	fill_command_SG(command, nents);
+
+	/*
+	 * Populate the command header.
+	 */
+	command->commandHeader->opts = cpu_to_le32(
+			(nents << 16) | 5 | AHCI_CMD_PREFETCH);
+	command->commandHeader->byteCount = 0;
+
+	/*
+	 * Set the completion function and data for the command
+	 * within this layer.
+	 */
+	command->completionData = dd;
+	command->completionFunc = async_read_complete;
+
+	/*
+	 * Set the completion function and data for the command passed
+	 * from the upper layer.
+	 */
+	command->asyncData = data;
+	command->asyncCallback = callback;
+
+	/*
+	 * Lock used to prevent this command from being issued
+	 * if an internal command is in progress.
+	 */
+	down_read(&port->dd->internalSem);
+
+	atomic_inc(&dd->statistics.reads);
+
+	/*
+	 * Issue the command to the hardware.
+	 */
+	issue_command(port, tag);
+
+#ifdef COMMAND_TIMEOUT
+	/* Set the command's timeout value.*/
+	port->commands[tag].compTime = jiffies + msecs_to_jiffies(
+					NCQ_COMMAND_TIMEOUT_MS);
+#endif
+
+	up_read(&port->dd->internalSem);
+
+	return 0;
+}
+
+/**
+ * @brief Obtain a command slot and return its associated scatter list.
+ *
+ * @param dd Pointer to the driver data structure.
+ * @param tag Pointer to an int that will receive the allocated command
slot tag.
+ *
+ * @return Pointer to the scatter list for the allocated command slot
or NULL if
+ * no command slots are available.
+ */
+struct scatterlist *ahci_get_scatterlist(struct driver_data *dd, int
*tag)
+{
+	/*
+	 * It is possible that, even with this semaphore, a thread
+	 * may think that no command slots are available. Therefore, we
+	 * need to make an appempt for  get_slot().
+	 */
+	down(&dd->port->commandSlot);
+	*tag = get_slot(dd->port);
+	if (unlikely(*tag  < 0)) {
+		/*printk(KERN_WARNING "%s: No free command slots\n",
+		 * __func__);*/
+	}
+	return dd->port->commands[*tag].sg;
+}
+
+/**
+ * @brief Get the drive capacity in sectors.
+ *
+ * This function obtains the drive capacity by
+ * issuing a READ NATIVE MAX EXT command to the drive.
+ *
+ * @return Highest sector number accessible on the drive.
+ */
+sector_t ahci_get_capacity(struct driver_data *dd)
+{
+	sector_t capacity;
+
+	if (dd->product_type != PRODUCT_OLDFPGA) {
+		/*why do we have two functions to do the same thing
+		*in different ways?
+		*/
+		if (!getCapacity(dd->port, &capacity)) {
+			printk(KERN_ERR "Error: unable to determine
capacity.\n");
+			/*FIXME: Look for a better way to report
failure.*/
+			capacity = 0;
+		}
+		return capacity;
+	}
+
+	/* This doesn't work on the ASIC yet.*/
+	return read_max_address(dd->port);
+}
+
+/**
+ * @brief Get the hardware block size.
+ *
+ * For Cyclone this is 4KB
+ *
+ * @retval 4096 for Cyclone devices.
+ */
+int ahci_hard_blksize(void)
+{
+	return 4096;
+}
+
+/**
+ * @brief Copy the statistical information to the supplied buffer.
+ *
+ * @param dev Pointer to the device structure, passed by the kernrel.
+ * @param attr Pointer to the device_attribute structure passed by the
kernel.
+ * @param buf Pointer to the char buffer that will receive the stats
info.
+ *
+ * @return The size, in bytes, of the data pointed to by buf.
+ */
+static ssize_t ahci_show_stats(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct driver_data *dd = dev_to_disk(dev)->private_data;
+	int size;
+
+	/*
+	 * Protect us from the timer that updates the statistics
counters.
+	 */
+	size = sprintf(buf, "%s:Ints = %d, reads = %d, writes = %d, IOPS
=%d\n",
+		__func__,
+		(unsigned int) atomic_read(&dd->statistics.currentInts),
+		(unsigned int)
atomic_read(&dd->statistics.currentReads),
+		(unsigned int)
atomic_read(&dd->statistics.currentWrites),
+		(unsigned int) atomic_read(&dd->statistics.currentIOPS)
+	);
+
+	return size;
+}
+static DEVICE_ATTR(statistics, S_IRUGO, ahci_show_stats, NULL);
+
+/**
+ * @brief Copy the important register information to the supplied
buffer.
+ *
+ * @param dev Pointer to the device structure, passed by the kernrel.
+ * @param attr Pointer to the device_attribute structure passed by the
kernel.
+ * @param buf Pointer to the char buffer that will receive the stats
info.
+ *
+ * @return The size, in bytes, of the data pointed to by buf.
+ */
+static ssize_t ahci_show_registers(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct driver_data *dd = dev_to_disk(dev)->private_data;
+	int size = 0;
+	int n;
+
+	size += sprintf(&buf[size], "%s:\nSActive:\n", __func__);
+
+	for (n = 0; n < dd->slot_groups; n++)
+		size += sprintf(&buf[size], "0x%08x\n",
+					 readl(dd->port->SActive[n]));
+
+	size += sprintf(&buf[size], "Command Issue:\n");
+
+	for (n = 0; n < dd->slot_groups; n++)
+		size += sprintf(&buf[size], "0x%08x\n",
+
readl(dd->port->CommandIssue[n]));
+
+	size += sprintf(&buf[size], "Allocated:\n");
+
+	for (n = 0; n < dd->slot_groups; n++) {
+		/* some magic to work around the fact that 'allocated'
+		 * is an array of longs.*/
+		u32 group_allocated;
+		if (sizeof(long) > sizeof(u32))
+			group_allocated =
+					dd->port->allocated[n/2] >>
(32*(n&1));
+		else
+			group_allocated = dd->port->allocated[n];
+		size += sprintf(&buf[size], "0x%08x\n",
+				 group_allocated);
+	}
+
+	size += sprintf(&buf[size], "Completed:\n");
+
+	for (n = 0; n < dd->slot_groups; n++)
+		size += sprintf(&buf[size], "0x%08x\n",
+				readl(dd->port->Completed[n]));
+
+	size += sprintf(&buf[size], "PORT_IRQ_STAT 0x%08x\n",
+				readl(dd->port->mmio + PORT_IRQ_STAT));
+	size += sprintf(&buf[size], "HOST_IRQ_STAT 0x%08x\n",
+				readl(dd->mmio + HOST_IRQ_STAT));
+
+	return size;
+}
+static DEVICE_ATTR(registers, S_IRUGO, ahci_show_registers, NULL);
+
+static ssize_t ahci_show_resptime(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct driver_data *dd = dev_to_disk(dev)->private_data;
+	int size = 0;
+
+	size += sprintf(&buf[size], "%s:\nResponse Time (us):\n",
__func__);
+	size += sprintf(&buf[size], "Min\tMax\tAvg\n");
+	size += sprintf(&buf[size], "%d\t%d\t%d\n",
+			atomic_read(&dd->statistics.minRespTime),
+			atomic_read(&dd->statistics.minRespTime),
+
atomic_read(&dd->statistics.currentAvgRespTime));
+
+	return size;
+}
+static DEVICE_ATTR(resptime, S_IRUGO, ahci_show_resptime, NULL);
+
+static ssize_t ahci_show_makeItFail(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct driver_data *dd = dev_to_disk(dev)->private_data;
+	int size = 0;
+
+	size += sprintf(&buf[size], "%d\n", dd->makeItFail);
+
+	return size;
+}
+
+static ssize_t ahci_store_makeItFail(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	struct driver_data *dd = dev_to_disk(dev)->private_data;
+	sscanf(buf, "%d", &dd->makeItFail);
+
+	if (dd->makeItFail & 0x01) {
+		get_random_bytes(&dd->randomReadCount,
+				sizeof(dd->randomReadCount));
+		dd->randomReadCount &= 0xffffff;
+		printk(KERN_INFO "%s: Random read count = %d\n",
+				__func__,
+				dd->randomReadCount);
+	}
+
+	if (dd->makeItFail & 0x02) {
+		get_random_bytes(&dd->randomWriteCount,
+				sizeof(dd->randomWriteCount));
+		dd->randomWriteCount &= 0xfffff;
+		printk(KERN_INFO "%s: Random write count = %d\n",
__func__,
+				dd->randomWriteCount);
+	}
+
+	return len;
+}
+static DEVICE_ATTR(make_it_fail,
+			S_IRUGO | S_IWUGO,
+			ahci_show_makeItFail,
+			ahci_store_makeItFail);
+
+static ssize_t ahci_store_reset(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf,
+			size_t len)
+{
+	struct driver_data *dd = dev_to_disk(dev)->private_data;
+	int val;
+	sscanf(buf, "%d", &val);
+
+	if (val == 1)
+		restart_port(dd->port);
+	/* fake a TFE to get rid of hung commands.*/
+	if (val == 4)
+		handleTFE(dd);
+
+	return len;
+}
+
+
+static DEVICE_ATTR(reset, S_IRUGO , NULL, ahci_store_reset);
+
+/**
+ * @brief Create the sysfs related attributes.
+ *
+ * @param dd Pointer to the driver data structure.
+* @param kobj Pointer to the kobj for the block device.
+ *
+ * @retval 0 Operation completed successfully.
+ * @retval -EINVAL Invalid parameter.
+ */
+int ahci_sysfs_init(struct driver_data *dd, struct kobject *kobj)
+{
+	if (!kobj || !dd)
+		return -EINVAL;
+
+	if (sysfs_create_file(kobj, &dev_attr_statistics.attr))
+		printk(KERN_ERR "%s: Error creating statistics sysfs
attribute\n",
+					__func__);
+	if (sysfs_create_file(kobj, &dev_attr_registers.attr))
+		printk(KERN_ERR "%s: Error creating registers sysfs
attribute\n",
+					__func__);
+	if (sysfs_create_file(kobj, &dev_attr_resptime.attr))
+		printk(KERN_ERR "%s: Error creating resptime sysfs
attribute\n",
+					__func__);
+	if (sysfs_create_file(kobj, &dev_attr_make_it_fail.attr))
+		printk(KERN_ERR "%s: Error creating make_it_fail sysfs
attribute\n",
+					__func__);
+	if (sysfs_create_file(kobj, &dev_attr_reset.attr))
+		printk(KERN_ERR "%s: Error creating reset sysfs
attribute\n",
+					__func__);
+
+	return 0;
+}
+
+/**
+ * @brief Remove the sysfs related attributes.
+ *
+ * @param dd Pointer to the driver data structure.
+ * @param kobj Pointer to the kobj for the block device.
+ *
+ * @retval 0 Operation completed successfully.
+ * @retval -EINVAL Invalid parameter.
+ */
+int ahci_sysfs_exit(struct driver_data *dd, struct kobject *kobj)
+{
+	if (!kobj || !dd)
+		return -EINVAL;
+
+	sysfs_remove_file(kobj, &dev_attr_registers.attr);
+	sysfs_remove_file(kobj, &dev_attr_statistics.attr);
+	sysfs_remove_file(kobj, &dev_attr_resptime.attr);
+	sysfs_remove_file(kobj, &dev_attr_make_it_fail.attr);
+	sysfs_remove_file(kobj, &dev_attr_reset.attr);
+
+	return 0;
+}
+
+/**
+ * @brief Statistics timer.
+ *
+ * Triggered once per second to update the performance counters.
+ *
+ * @param data Pointer to the STATS structure.
+ *
+ * @return N/A
+ */
+static void stats_timeout(unsigned long int data)
+{
+	struct STATS *stats = (struct STATS *) data;
+
+	atomic_set(&stats->currentInts,
atomic_read(&stats->interrupts));
+	atomic_set(&stats->interrupts, 0);
+
+	atomic_set(&stats->currentReads, atomic_read(&stats->reads));
+	atomic_set(&stats->reads, 0);
+
+	atomic_set(&stats->currentWrites, atomic_read(&stats->writes));
+	atomic_set(&stats->writes, 0);
+
+	atomic_set(
+	  &stats->currentIOPS,
+	  atomic_read(&stats->currentReads) + atomic_read(
+						&stats->currentWrites));
+
+	if (atomic_read(&stats->currentIOPS))
+		atomic_set(&stats->currentAvgRespTime,
+				100000000 /
atomic_read(&stats->currentIOPS));
+	else
+		atomic_set(&stats->currentAvgRespTime, 0);
+
+	atomic_set(&stats->avgRespTime, 0);
+
+	mod_timer(&stats->timer, jiffies + msecs_to_jiffies(1000));
+}
+
+/**
+ * @brief Initialize the statistics counters.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return N/A
+ */
+static void stats_init(struct driver_data *dd)
+{
+	atomic_set(&dd->statistics.interrupts, 0);
+	atomic_set(&dd->statistics.reads, 0);
+	atomic_set(&dd->statistics.writes, 0);
+	atomic_set(&dd->statistics.avgRespTime, 0);
+	atomic_set(&dd->statistics.currentInts, 0);
+	atomic_set(&dd->statistics.currentReads, 0);
+	atomic_set(&dd->statistics.currentWrites, 0);
+	atomic_set(&dd->statistics.currentAvgRespTime, 0);
+	init_timer(&dd->statistics.timer);
+	dd->statistics.timer.data = (unsigned long int) &dd->statistics;
+	dd->statistics.timer.function = stats_timeout;
+}
+
+/**
+ * @brief Start statistics collection.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return N/A
+ */
+static void stats_start(struct driver_data *dd)
+{
+	/*
+	 * Start the statistics timer, once per second.
+	 */
+	mod_timer(&dd->statistics.timer, jiffies +
msecs_to_jiffies(1000));
+}
+
+/**
+ * @brief Stop statistics collection.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return N/A
+ */
+static void stats_stop(struct driver_data *dd)
+{
+	/*
+	 * Stop the performance statistics timer.
+	 */
+	del_timer_sync(&dd->statistics.timer);
+}
+
+/**
+ * @brief Perform any one-time hardware setup
+ *
+ * Perform any hardware initialization steps that are needed
+ * at driver initialization time or when resuming from a
+ * suspended state.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return N/A
+ */
+void hba_setup(struct driver_data *dd)
+{
+	u32 hwdata;
+	hwdata = readl(dd->mmio + HOST_HSORG);
+
+	/* interrupt bug workaround: use only 1 IS bit.*/
+	writel(hwdata |
HSORG_DISABLE_SLOTGRP_INTR|HSORG_DISABLE_SLOTGRP_PXIS,
+		 dd->mmio + HOST_HSORG);
+}
+
+/**
+ * @brief Detect the design and interface version.
+ *
+ * Detect the details of the product, and store anything needed
+ * into the driver data structure.  This includes product type and
+ * version and number of slot groups.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return N/A
+ */
+static void detect_product(struct driver_data *dd)
+{
+	u32 hwdata;
+	/* HBA base + 0xFC [15:0] - vendor-specific hardware interface
+	 * info register:
+	 * [15:8] hardware/software interface rev#
+	 * [   3] asic-style interface
+	 * [ 2:0] number of slot groups, minus 1 (only valid for
asic-style).
+	 */
+	hwdata = readl(dd->mmio + HOST_HSORG);
+
+	dd->product_type = PRODUCT_UNKNOWN;
+
+	if ((hwdata & HSORG_STYLE) == 0) {
+		printk(KERN_INFO "Detected an old FPGA design. Assuming
4 slot groups, 128 slots.\n");
+		dd->product_type = PRODUCT_OLDFPGA;
+		dd->slot_groups = 4;
+	} else if (hwdata & 0x8) {
+		unsigned int rev, slotgroups;
+
+		dd->product_type = PRODUCT_ASICFPGA;
+		rev = hwdata & HSORG_HWREV >> 4;
+		slotgroups = (hwdata & HSORG_SLOTGROUPS) + 1;
+		printk(KERN_INFO "ASIC-FPGA design, HS rev 0x%x, %i slot
groups, %i slots\n",
+				 rev,
+				 slotgroups,
+				 slotgroups*32);
+
+		if (slotgroups > MAX_SLOT_GROUPS) {
+			printk(KERN_WARNING "Warning: driver only
supports %i slot groups.\n",
+						 MAX_SLOT_GROUPS);
+			slotgroups = MAX_SLOT_GROUPS;
+		}
+		dd->slot_groups = slotgroups;
+	}
+}
+
+/**
+ * @brief Called once for each Cyclone AHCI device.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return 0 on success, else an error code.
+ */
+int ahci_init(struct driver_data *dd)
+{
+	int i;
+	int rv;
+	unsigned int num_command_slots;
+
+	dd->mmio = pcim_iomap_table(dd->pdev)[MTIPX2XX_ABAR];
+
+	detect_product(dd);
+	if (dd->product_type == PRODUCT_UNKNOWN) {
+		rv = -EIO;
+		goto out1;
+	}
+	num_command_slots = dd->slot_groups * 32;
+
+	hba_setup(dd);
+
+	stats_init(dd);
+
+	/*
+	 * Initialize the spin lock for accessing the SActive register
and
+	 * the port->active variable.
+	 */
+	spin_lock_init(&dd->makeItFailLock);
+	init_rwsem(&dd->internalSem);
+
+#if USE_TASKLET
+	tasklet_init(&dd->tasklet, tasklet_proc, (unsigned long)dd);
+#endif
+
+	/*
+	 * Allocate memory for the port structures. Use vmalloc rather
than
+	 * kmalloc since we don't need this memory to be physically
contiguous.
+	 */
+	dd->port = vmalloc(sizeof(struct port));
+
+	if (dd->port == NULL) {
+		printk(KERN_ERR "Unable to allocate memory for port
structure\n");
+		return -ENOMEM;
+	}
+	memset(dd->port, 0, sizeof(struct port));
+
+	sema_init(&dd->port->commandSlot, num_command_slots - 1);
+	spin_lock_init(&dd->port->cmdIssueLock);
+
+	/*
+	 * Set the port mmio base address.
+	 */
+	dd->port->mmio	= dd->mmio + PORT_OFFSET;
+	dd->port->dd	= dd;
+
+	/*
+	 * Allocate memory for the command list.
+	 */
+	dd->port->commandList = dmam_alloc_coherent(&dd->pdev->dev,
+				AHCI_PORT_PRIV_DMA_SZ + (ATA_SECT_SIZE *
2),
+				&dd->port->commandListDMA,
+				GFP_KERNEL);
+	if (dd->port->commandList == NULL) {
+		printk(KERN_ERR "Cannot allocate memory for AHCI
structures!\n");
+		rv = -ENOMEM;
+		goto out1;
+	}
+	/*
+	 * Clear the memory we have allocated.
+	 */
+	memset(dd->port->commandList,
+				0,
+				AHCI_PORT_PRIV_DMA_SZ + (ATA_SECT_SIZE *
2));
+
+	/*
+	 * Setup the addresse of the RX FIS.
+	 */
+	dd->port->rxFIS		= dd->port->commandList +
AHCI_CMD_SLOT_SZ;
+	dd->port->rxFISDMA	= dd->port->commandListDMA +
AHCI_CMD_SLOT_SZ;
+
+	/*
+	 * Setup the address of the command tables.
+	 */
+	dd->port->commandTbl	= dd->port->rxFIS + AHCI_RX_FIS_SZ;
+	dd->port->commandTblDMA	= dd->port->rxFISDMA + AHCI_RX_FIS_SZ;
+
+	/*
+	 * Setup the address of the identify data.
+	 */
+	dd->port->identify	= dd->port->commandTbl +
AHCI_CMD_TBL_AR_SZ;
+	dd->port->identifyDMA	= dd->port->commandTblDMA +
AHCI_CMD_TBL_AR_SZ;
+
+	/*
+	 * Setup the address of the sector buffer.
+	 */
+	dd->port->sectorBuffer	= (void *) dd->port->identify +
ATA_SECT_SIZE;
+	dd->port->sectorBufferDMA = dd->port->identifyDMA +
ATA_SECT_SIZE;
+
+	/*
+	 * Point the command headers at the command tables.
+	 */
+	for (i = 0; i < num_command_slots; i++) {
+		dd->port->commands[i].commandHeader =
+					dd->port->commandList +
+					(sizeof(struct COMMAND_HDR) *
i);
+		dd->port->commands[i].commandHeaderDMA =
+					dd->port->commandListDMA +
+					(sizeof(struct COMMAND_HDR) *
i);
+
+		dd->port->commands[i].command = dd->port->commandTbl +
+							(AHCI_CMD_TBL_SZ
* i);
+		dd->port->commands[i].commandDMA =
dd->port->commandTblDMA +
+							(AHCI_CMD_TBL_SZ
* i);
+
+		if (readl(dd->mmio + HBA_CAPS) & HOST_CAP_64)
+			dd->port->commands[i].commandHeader->ctbau =
+			cpu_to_le32(
+			(dd->port->commands[i].commandDMA >> 16) >> 16);
+		dd->port->commands[i].commandHeader->ctba = cpu_to_le32(
+			dd->port->commands[i].commandDMA & 0xffffffff);
+
+		/*
+		 * If this is not done a bug is reported by the stock
FC11 i386.
+		 * Due to the fact that it has lots of kernel debugging
enabled.
+		 */
+		sg_init_table(dd->port->commands[i].sg, MAX_SG);
+		/* Mark all commands as currently inactive.*/
+		atomic_set(&dd->port->commands[i].active, 0);
+	}
+
+	/*
+	 * Setup the pointers to the extended SActive and CI registers.
+	 */
+	if (dd->product_type == PRODUCT_ASICFPGA) {
+		for (i = 0; i < dd->slot_groups; i++) {
+			dd->port->SActive[i] =
+				dd->port->mmio + i*0x80 + PORT_SACTIVE;
+			dd->port->CommandIssue[i] =
+				dd->port->mmio + i*0x80 +
PORT_COMMAND_ISSUE;
+			dd->port->Completed[i] =
+				dd->port->mmio + i*0x80 + PORT_SDBV;
+		}
+	} else if (dd->product_type == PRODUCT_OLDFPGA) {
+		dd->port->SActive[0]	= dd->port->mmio + PORT_SACTIVE;
+		dd->port->CommandIssue[0] =
+				dd->port->mmio + PORT_COMMAND_ISSUE;
+		for (i = 1; i < dd->slot_groups; i++) {
+			dd->port->SActive[i] = dd->mmio + 0xa0 + (8 *
(i-1));
+			dd->port->CommandIssue[i] =
+					dd->mmio + 0xa4 + (8 * (i-1));
+		}
+		/* Set up pointers to the Completed registers.*/
+		for (i = 0; i < dd->slot_groups; i++)
+			dd->port->Completed[i] = dd->mmio + 0xd8 + (4 *
i);
+
+	}
+
+	/*
+	* Reset the HBA.
+	*/
+	if (hba_reset(dd) < 0) {
+		printk(KERN_ERR "HBA did not reset within timeout\n");
+		rv = -EIO;
+		goto out2;
+	}
+
+	init_port(dd->port);
+	start_port(dd->port);
+
+	/*
+	 * Setup the ISR and enable interrupts.
+	 */
+	rv = devm_request_irq(&dd->pdev->dev,
+				dd->pdev->irq,
+				irq_handler,
+				IRQF_SHARED,
+				dev_driver_string(&dd->pdev->dev),
+				dd);
+
+	if (rv) {
+		printk(KERN_ERR "Unable to allocate IRQ %d\n",
dd->pdev->irq);
+		goto out2;
+	}
+
+	/*
+	 * Enable interrupts on the HBA.
+	 */
+	writel(readl(dd->mmio + HOST_CTRL) | HOST_IRQ_EN, dd->mmio +
HOST_CTRL);
+
+#ifdef COMMAND_TIMEOUT
+	init_timer(&dd->port->commandTimer);
+	dd->port->commandTimer.data = (unsigned long int) dd->port;
+	dd->port->commandTimer.function = timeout_function;
+	mod_timer(&dd->port->commandTimer,
+			jiffies +
msecs_to_jiffies(TIMEOUT_CHECK_PERIOD));
+#endif
+
+/*	restart_port(dd->port);
+	softwareReset(dd->port);
+
+	memset(dd->port->sectorBuffer, 0, 512);
+	read_logpage(dd->port, ATA_LOG_SATA_NCQ,
dd->port->sectorBufferDMA, 1);
+	dump_buffer(dd->port->sectorBuffer, 512);
+	read_logpage(dd->port, 0, dd->port->sectorBufferDMA, 1);
+*/
+
+	get_identify(dd->port, NULL);
+	dump_identify(dd->port);
+
+	/*
+	 * Bit 15 of this register needs to be cleared to
+	 * enable 128 command slots in some hardware versions.
+	 */
+	/*FIXME: is this still required?*/
+	if (dd->product_type == PRODUCT_OLDFPGA)
+		writel(0x0, dd->mmio + 0xfc);
+
+
+	stats_start(dd);
+
+	return rv;
+
+/*out3:   label currently unused, but want to preserve the code
+ * in case of future need.*/
+#ifdef COMMAND_TIMEOUT
+	del_timer_sync(&dd->port->commandTimer);
+#endif
+	/*
+	 * Disable interrupts on the HBA.
+	 */
+	writel(readl(dd->mmio + HOST_CTRL) & ~HOST_IRQ_EN,
+			dd->mmio + HOST_CTRL);
+
+	/*
+	 * Release the IRQ.
+	 */
+	devm_free_irq(&dd->pdev->dev, dd->pdev->irq, dd);
+
+out2:
+	deinit_port(dd->port);
+
+	/*
+	 * Free the command/command header memory.
+	 */
+	dmam_free_coherent(&dd->pdev->dev,
+				AHCI_PORT_PRIV_DMA_SZ + (ATA_SECT_SIZE *
2),
+				dd->port->commandList,
+				dd->port->commandListDMA);
+out1:
+	/*
+	 * Free the memory allocated for the for structure.
+	 */
+	vfree(dd->port);
+
+	return rv;
+}
+
+/**
+ * @brief Called to deinitialize an AHCI interface.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return This function always returns 0.
+ */
+int ahci_exit(struct driver_data *dd)
+{
+	stats_stop(dd);
+
+	/*
+	 * Send standby immediate (E0h) to the drive so that it
+	 * saves its state.
+	 */
+	if (atomic_read(&dd->drv_cleanup_done) != true) {
+
+			standby_immediate(dd->port);
+
+			/*
+			* de-initialize the port.
+			*/
+			deinit_port(dd->port);
+
+			/*
+			* Disable interrupts on the HBA.
+			*/
+			writel(readl(dd->mmio + HOST_CTRL) &
~HOST_IRQ_EN,
+					dd->mmio + HOST_CTRL);
+		}
+
+#ifdef COMMAND_TIMEOUT
+	del_timer_sync(&dd->port->commandTimer);
+#endif
+
+#if USE_TASKLET
+	/*
+	 * Stop the bottom half tasklet.
+	 */
+	tasklet_kill(&dd->tasklet);
+#endif
+
+	/*
+	 * Release the IRQ.
+	 */
+	devm_free_irq(&dd->pdev->dev, dd->pdev->irq, dd);
+
+	/* Workaround for Fedora 14 crash:
+	* Must have delay between free_irq and driver exit.
+	*/
+	msleep(100);
+
+	/*
+	 * Free the command/command header memory.
+	 */
+	dmam_free_coherent(&dd->pdev->dev,
+			AHCI_PORT_PRIV_DMA_SZ + (ATA_SECT_SIZE * 2),
+			dd->port->commandList,
+			dd->port->commandListDMA);
+	/*
+	 * Free the memory allocated for the for structure.
+	 */
+	vfree(dd->port);
+
+	return 0;
+}
+
+/**
+ * @brief Issue a Standby Immediate command to the device.
+ *
+ * This function is called by the Block Layer just before the
+ * system powers off during a shutdown.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return This function always returns 0.
+ */
+int ahci_shutdown(struct driver_data *dd)
+{
+	/*
+	 * Send standby immediate (E0h) to the drive so that it
+	 * saves its state.
+	 */
+	standby_immediate(dd->port);
+
+	return 0;
+}
+
+int ahci_suspend(struct driver_data *dd)
+{
+		/* Send standby immediate (E0h) to the drive
+		 *  so that it saves its state.*/
+		if (standby_immediate(dd->port) != 0) {
+			printk(KERN_ERR "Failed to send
standby-immediate command\n");
+			return FAILURE;
+		}
+
+		/* Disable interrupts on the HBA.*/
+		writel(readl(dd->mmio + HOST_CTRL) & ~HOST_IRQ_EN,
+				dd->mmio + HOST_CTRL);
+		deinit_port(dd->port);
+
+		return SUCCESS;
+}
+
+int ahci_resume(struct driver_data *dd)
+{
+		/*Perform any needed hardware setup steps*/
+		hba_setup(dd);
+
+		/* Reset the HBA*/
+		if (hba_reset(dd) != 0) {
+			printk(KERN_ERR "Unable to reset the HBA\n");
+			return FAILURE;
+		}
+
+		/* Enable the port, the DMA engine and FIS reception
specific
+		* h/w in controller.
+		*/
+		init_port(dd->port);
+		start_port(dd->port);
+
+		/* Enable interrupts on the HBA.*/
+		writel(readl(dd->mmio + HOST_CTRL) | HOST_IRQ_EN,
+				dd->mmio + HOST_CTRL);
+
+		return SUCCESS;
+}
+
+/* * This function command_cleanup is called for clean the pending
+ * command in the command slot during the surprise removal of device
+ * and return error to the upper layer.
+ *
+ *
+ * @param dd Pointer to the DRIVER_DATA structure.
+ *
+ *
+ * @return N/A
+ */
+
+void command_cleanup(struct driver_data *dd)
+{
+		int Group = 0, commandslot = 0, commandindex = 0;
+		struct COMMAND *command;
+		struct HOST_TO_DEV_FIS *fis;
+		struct port *port = dd->port;
+
+		for (Group = 0; Group < 4; Group++) {
+			for (commandslot = 0; commandslot < 32;
commandslot++) {
+				if (
+				(port->allocated[Group] << commandslot)
== 1) {
+					commandindex =
+					Group  << 5 | commandslot;
+					command =
+					&port->commands[commandindex];
+					if (atomic_read(
+					&command->active)
+					&& (command->asyncCallback)
+					)
+						command->asyncCallback(
+						command->asyncData,
+						ENODEV);
+					fis =
+					(struct HOST_TO_DEV_FIS *)
+					command->command;
+					if (fis->command ==
ATA_CMD_FPDMA_WRITE)
+						dma_unmap_sg(
+						&port->dd->pdev->dev,
+						command->sg,
+						command->scatterEnts,
+						DMA_TO_DEVICE);
+					else
+						dma_unmap_sg(
+
&port->dd->pdev->dev,
+							command->sg,
+
command->scatterEnts,
+
DMA_FROM_DEVICE);
+
+				}
+			}
+		}
+
+
+		up(&port->commandSlot);
+
+		/*
+		* Set the atomic variable as 1 in case of SRSI
+		*/
+		atomic_set(&dd->drv_cleanup_done, true);
+}


