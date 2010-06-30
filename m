From: amruth pattanada <amruth.vamadev@gmail.com>
Subject: Re: Setting up Silicon image 3114 in DMA mode
Date: Wed, 30 Jun 2010 18:00:59 +0530
Message-ID: <AANLkTimOu5GfUN848EOiMIZONHrRjgYyexmwBL3OCAMs@mail.gmail.com>
References: <AANLkTinYuxwsLQKGRd6joRSCcbnns930DDienlhfEB8i@mail.gmail.com>
	<4C257E67.9090101@gmail.com>
	<AANLkTikeQO1v-ag_DDbkgxoZRTk1_fomn1kbHKqH9vkD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51624 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab0F3MbA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 08:31:00 -0400
In-Reply-To: <AANLkTikeQO1v-ag_DDbkgxoZRTk1_fomn1kbHKqH9vkD@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi
I need some clarification regarding read DMA data from silicon image
controller. How do know that DMA transfer happened and where to look
for the data after the transfer. Should we look at BAR2 channel X Task
file register data word or look into allocated DMA buffer which is
specified in the PRD table. I am reading 0x00 in the PRD table scatter
gather list and it hangs in the when I tried to read data word of
channel task file register. Please let me know how to read data buffer
after the DMA is complete.
Thanks
Amruth p.v

On Sat, Jun 26, 2010 at 8:36 PM, amruth pattanada
<amruth.vamadev@gmail.com> wrote:
> Thanks for the info Robert. I checked the code for open solaris and
> see the following below. It basically uses BAR5 indirect access
> method.
>
> /* Base Register 5 Indirect Address Offset */
>
> #define PCI_CONF_BA5_IND_ADDRESS =A0 =A0 =A0 =A00xc0
> #define PCI_CONF_BA5_IND_ACCESS =A0 =A0 =A0 =A0 0xc4
>
> #define PUT_BAR5_INDIRECT(handle, address, value) \
> {\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_config_put32(handle, PCI_CONF_BA5_=
IND_ADDRESS, address); \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_config_put32(handle, PCI_CONF_BA5_=
IND_ACCESS, value); \
> }
>
> #define GET_BAR5_INDIRECT(handle, address, rval) \
> {\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_config_put32(handle, PCI_CONF_BA5_=
IND_ADDRESS, address); \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rval =3D pci_config_get32(handle, PCI_=
CONF_BA5_IND_ACCESS); \
> }
>
> /*
> =A0 =A0 =A0 =A0 * The following BAR5 registers are accessed via an in=
direct register
> =A0 =A0 =A0 =A0 * in the PCI configuration space rather than mapping =
BAR5.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0for (i =3D 0; i < ports; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GET_BAR5_INDIRECT(pci_conf_handle, fif=
ocntctl[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fifo_cnt_ctl);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fifo_cnt_ctl =3D (fifo_cnt_ctl & ~0x7)=
 | (frrc & 0x7);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PUT_BAR5_INDIRECT(pci_conf_handle, fif=
ocntctl[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fifo_cnt_ctl);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Correct default setting for FIS0cfg
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> #ifdef =A0DEBUG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GET_BAR5_INDIRECT(pci_conf_handle, sfi=
scfg[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfiscfg_val);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ADBG_WARN(("sil3xxx_init_controller: o=
ld val SFISCfg "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ch%d: %x\n", i, sfisc=
fg_val));
> #endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PUT_BAR5_INDIRECT(pci_conf_handle, sfi=
scfg[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SFISCFG_ERRATA);
> #ifdef =A0DEBUG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GET_BAR5_INDIRECT(pci_conf_handle, sfi=
scfg[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfiscfg_val);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ADBG_WARN(("sil3xxx_init_controller: n=
ew val SFISCfg "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ch%d: %x\n", i, sfisc=
fg_val));
> #endif
>
> I need to setup DMA transfer mode for silicon image 3114 chipset for
> dma write/read operation.Where can I find the initialisation steps fo=
r
> DMA in libata(Programming Bus Master Registers,setup PRD table and
> Issue ATA commands). Do we have any sample implementation in libata.
> Please let me know.
> Thanks
> Amruth p.v
> Sr.Embedded Engineer
> On Sat, Jun 26, 2010 at 9:43 AM, Robert Hancock <hancockrwd@gmail.com=
> wrote:
>> On 06/25/2010 02:25 AM, amruth pattanada wrote:
>>>
>>> Hi
>>> Can anybody please guide me what minimal steps to follow for settin=
g
>>> up 3114 for operating in DMA mode and looked into linux 2.6.32.7 co=
de.
>>> I am porting 3114 driver to RTOS but have problems in using BAR5 PC=
I
>>> config space because of Memory mapped region issues. I can access B=
AR4
>>> and plan to set up DMA mode.
>>> How do we access entire BAR5 memory space without using BAR5, is th=
ere
>>> any indirect way to access BAR5 using BAR4. Please let me know.
>>> Thanks
>>> Amruth p.v
>>> Sr.Embedded Engineer
>>
>> See the datasheet (PCI Configuration Space section), there's a way t=
o access
>> BAR5 registers using indirect access registers in configuration spac=
e. I
>> expect this will be relatively slow, however.
>>
>
