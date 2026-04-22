Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F037BE6F;
	Wed, 22 Apr 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845028; cv=none; b=ncT4LIzEsi4nJ6fKE3NlVAWotOqRS4PhUVfV7niv58/gZO8f/t/Cs6jGn9kNeLMlACvCxCty0XFxubNrNiAhWTAGGYgKDpK9UlbA0xV0Jc8ImEzP3fRSCccrQSBQLtFuTHZYqjMo4u47EjZjecu9Vp7AK2SdKK3+3AqITh+oNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845028; c=relaxed/simple;
	bh=urkZt31lbbLkpQNkQ/Fs6wvOVIIaHWPILqZE9IPJP4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWM8wGXAatRA/m+/DVAYoOgw/7Aso9NzMdACyWoqkUGYUREq0gHiyG5V0q3p4ikyBJootZ6s36f6eJ2Q0AUFOVgf1eh1uU9iAqmbXsvpCXgrCwYgE2tKv8H2GuhwnlMKIMPEWLFzM/M7WoOQwpXZcvjSp+wjL+LLLDdVNo1+Xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R3Y7jc9H; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R3Y7jc9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dz
	UM66U/mmYOAhvCZdX3PhqgzKTSk0J60i999dBZQoM=; b=R3Y7jc9H2JG34YagoK
	FMZL4dJXP1451CeIuQa/4sMhycCTQNnBnBY7p2JSjE17mAtOFlI7Ey3wVZrfAN+3
	hXmQcyxRqUROPEfFIR7BQ6XbbmSQU7mfvzKYl5FDMX0UmOufpUprPcSKIgVfHuRH
	/2tun59tQg04lIc3mckvOD8Uw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHwy_MgOhpcBXyAw--.135S2;
	Wed, 22 Apr 2026 16:03:27 +0800 (CST)
From: dayou5941@163.com
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liyouhong@kylinos.cn
Subject: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO region
Date: Wed, 22 Apr 2026 16:03:22 +0800
Message-Id: <20260422080322.1006592-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHwy_MgOhpcBXyAw--.135S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr1DAw47ur1kZr1kZr1UJrb_yoW3GFW5pF
	W5WryxGrWkXrWxXa18J34UtF13Aa98Aay7GrZFyw1aka1UC34qvryUtayYg3WUJw48JFy3
	Kr1qqw1jkr1UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFpB-UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+Q-nlmnogM8CYgAA3p

From: liyouhong <liyouhong@kylinos.cn>

Commit 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps
initialization") introduced a regression where the driver would
attempt to access port registers beyond the mapped MMIO region when
HOST_PORTS_IMPL and HOST_CAP contains invalid values.

This occurs in scenarios where:
1. The AHCI controller is disabled by BIOS, causing registers to read
   as 0xFFFFFFFF.
2. HOST_PORTS_IMPL indicates more ports than physically implemented.
3. The actual MMIO region is smaller than needed for the indicated
ports.

When the driver iterates through ports indicated in HOST_PORTS_IMPL and
accesses PORT_CMD registers, it may calculate port offsets that exceed
the mapped MMIO region. On ARM64 systems, this causes a kernel panic.
when attempting to read from the unmapped address.

When mmio_size is 0x1000 and all ports need to be accessed.
The issue manifests as a panic in __raw_readl() when i=30, as the
calculated offset (0x1000) equals the typical MMIO region size (0x1000),
placing the access exactly at the boundary of the mapped region.

The log is as follows:
[    0.389751][    T1] Unable to handle kernel paging request at virtual address ffff800082916018
[    0.389752][    T1] Mem abort info:
[    0.389753][    T1]   ESR = 0x0000000096000007
[    0.389754][    T1]   EC = 0x25: D
ABT (current EL), IL = 32 bits
[    0.389756][    T1]   SET = 0, FnV = 0
[    0.389757][    T1]   EA = 0, S1PTW = 0
[    0.389758][    T1]   FSC = 0x07: level 3 translation fault
[    0.389759][    T1] Data abort info:
[    0.389760][    T1]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[    0.389761][    T1]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.389762][    T1] GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.389764][    T1] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000e16b1000
[    0.389766][    T1] [ffff800082916018] pgd=10000000e264d003, p4d=10000000e264d003, pud=10000000e264e003, pmd=10000000e2653003, pte=0000000000000000
[    0.389772][    T1] Internal error: Oops: 0000000096000007 [#1]  SMP
[    0.391912][    T1] Modules linked in:
[    0.397407][   T71] nvme nvme0: allocated 16 MiB host memory buffer (1 segment).
[    0.406067][   T71] nvme nvme0: 8/0/0 default/read/poll queues
[    0.426950][   T12]  nvme0n1: p1 p2 p3 p4 p5 p6
[    0.427171][   T71] probe of 0000:01:00.0 returned 0 after 37797 usecs
[    0.428770][   T80] Freeing initrd memory: 39012K
[   12.823718][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-dirty #3 PREEMPTLAZY 
[   12.832490][    T1] Hardware name: ISOFTSTONE COMPUTER TianYaoW600 Series/EM_FC19M, BIOS KL4.2B.EM.D.R003.RTHF.260414.R 04/14/2026 16:26:14
[   12.844992][    T1] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.852635][    T1] pc : ahci_init_one+0x6a8/0xf68
[   12.857417][    T1] lr : ahci_init_one+0x668/0xf68
[   12.862194][    T1] sp : ffff8000828aba20
[   12.866189][    T1] x29: ffff8000828aba20 x28: 000000000000001e x27: ffff800081742300
[   12.874007][    T1] x26: ffff0020289b8000 x25: 0000000000000001 x24: ffff002020f710d0
[   12.881823][    T1] x23: 0000000000000005 x22: ffff002026d9ee00 x21: ffff002026d9f280
[   12.889639][    T1] x20: ffff002020f71000 x19: 0000000000000000 x18: 00000000ffffffff
[   12.897456][    T1] x17: ffff002021c7c000 x16: ffff002020d6ee00 x15: ffff8000828ab850
[   12.905272][    T1] x14: ffff0020289ba42c x13: ffff0020289ba3f9 x12: 0101010101010101
[   12.913088][    T1] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000078 x9 : ffff800080bdf1b0
[   12.920905][    T1] x8 : 0000000000000030 x7 : 0000000000000008 x6 : ffff800081271928
[   12.928721][    T1] x5 : 0000000000000030 x4 : 0000000000000030 x3 : 0000000000000000
[   12.936537][    T1] x2 : ffff002026d9f280 x1 : 0000000000001018 x0 : ffff800082916018
[   12.944354][    T1] Call trace:
[   12.947481][    T1]  ahci_init_one+0x6a8/0xf68 (P)
[   12.952260][    T1]  local_pci_probe+0x44/0xb0
[   12.956693][    T1]  pci_device_probe+0xd4/0x268
[   12.961298][    T1]  really_probe+0xc4/0x3e8
[   12.965557][    T1]  __driver_probe_device+0xd4/0x188
[   12.970595][    T1]  driver_probe_device+0x40/0x118
[   12.975460][    T1]  __driver_attach+0xe8/0x218
[   12.979977][    T1]  bus_for_each_dev+0x7c/0xe0
[   12.984494][    T1]  driver_attach+0x28/0x38
[   12.988751][    T1]  bus_add_driver+0x120/0x248
[   12.993269][    T1]  driver_register+0x60/0x128
[   12.997787][    T1]  __pci_register_driver+0x50/0x60
[   13.002739][    T1]  ahci_pci_driver_init+0x28/0x38
[   13.007605][    T1]  do_one_initcall+0x58/0x450
[   13.012124][    T1]  kernel_init_freeable+0x1fc/0x560
[   13.017164][    T1]  kernel_init+0x28/0x1f8
[   13.021337][    T1]  ret_from_fork+0x10/0x20
[   13.025596][    T1] Code: 53196021 91046021 f9400840 8b010000 (b9400000) 
[   13.032370][    T1] ---[ end trace 0000000000000000 ]---
[   13.037737][    T1] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   13.046077][    T1] SMP: stopping secondary CPUs
[   13.050684][    T1] Kernel Offset: disabled
[   13.054852][    T1] CPU features: 0x0000000,000e0005,40230521,0401720b
[   13.061366][    T1] Memory Limit: none
[   13.065102][    T1] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Fix this by adding bounds checking in ahci_save_initial_config(). Before
accessing each port's PORT_CMD register, verify that the port's register
block offset is within the mapped MMIO region. Skip any ports that would
require accessing memory beyond the mapped region.

Fixes: 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps initialization")
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 2d1ca9f2f546..69de3560aeec 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -468,6 +468,8 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 	void __iomem *port_mmio;
 	unsigned long port_map;
 	u32 cap, cap2, vers;
+	unsigned long long mmio_size = 0;
+	bool is_pci_dev = false;
 	int i;
 
 	/* make sure AHCI mode is enabled before accessing CAP */
@@ -595,6 +597,13 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		hpriv->saved_port_map = port_map;
 	}
 
+	is_pci_dev = dev_is_pci(dev);
+	if (is_pci_dev) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		mmio_size = (unsigned long long)pci_resource_len(pdev, 5);
+	}
+
 	/*
 	 * Preserve the ports capabilities defined by the platform. Note there
 	 * is no need in storing the rest of the P#.CMD fields since they are
@@ -605,6 +614,29 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 			continue;
 
 		port_mmio = __ahci_port_base(hpriv, i);
+
+		/* Calculate offset from MMIO base */
+		unsigned long long port_offset = (unsigned long long)port_mmio -
+						 (unsigned long long)mmio;
+		/* Check if port register block is within MMIO region */
+		if (is_pci_dev && port_offset >= mmio_size) {
+			/*
+			 * Port registers exceed MMIO region boundary.
+			 * Since ports are sequentially mapped (0x100 + i*0x80),
+			 * all subsequent ports will also exceed the boundary.
+			 *
+			 * Update port_map to exclude this and all higher ports,
+			 * then break out of the loop.
+			 */
+			dev_warn(dev, "Port %d (offset 0x%llx) exceeds MMIO region (0x%llx),
+				       truncating port map at port %d\n",
+				       i, port_offset, mmio_size, i-1);
+
+			port_map = (1UL << i) - 1;
+			hpriv->saved_port_map = port_map;
+			break;
+		}
+
 		hpriv->saved_port_cap[i] =
 			readl(port_mmio + PORT_CMD) & PORT_CMD_CAP;
 	}
-- 
2.33.0

