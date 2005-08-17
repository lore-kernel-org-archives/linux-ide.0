From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:sil24 00/08] sil24: misc patches
Date: Wed, 17 Aug 2005 13:08:37 +0900 (KST)
Message-ID: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:47376 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750827AbVHQEIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:08:52 -0400
Received: by wproxy.gmail.com with SMTP id i2so85450wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:08:44 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

 Hello, Edward, Jeff and Carlos.

 These are misc patches against new sil24 driver acked by Jeff, and
two new ones from me and two new ones from Edward.  I'm sorry this
patchset took so long.  It just slipped my attention.  I hope this
wouldn't cause too much delay in Edward's work, so that we can include
this driver in mainline soon.

#01-#04: these are already acked by Jeff.  They can just go in.
#05-#06: two new ones from me.  It removes PORT_TF as it doesn't work.
#07-#08: constant fixes and comments from Edward Falk.

 Notes

* I haven't included the patch which adds IO flushing after masking
  irq during initialization, as it seems that it isn't necessary here.

>>>> FROM: Jeff
>>>>add a readl() to flush this write out to the PCI bus ("PCI posting")
>>>
>>> FROM: Me
>>> Sure.  And, out of curiosity, isn't sync unnecessary unless we're
>>>gonna perform some kind of timed waiting following it?  We don't have
>>>any timing requirement after above interrupt masking, do we?
>>
>> FROM: Edward
>>I think we're ok here; the code reads PORT_CTRL_STAT a few lines down;
>>that will flush the write.  I don't think there's a race condition
>>involved.
>
>FROM: Jeff
>No race condition.  Typically there is often a mistaken assumption that
>
>        writel(...)
>        udelay(...)
>
>will accomplish the desired effect.  Due to posted writes, the write may
>be posted to the PCI device after some delay, such that, the udelay()
>and the posted write execute concurrently, skewing the desired timing
>effect.

* Edward, I removed PORT_SLOT/PORT_SG stuff from your patch, as it
  currently isn't used anywhere.  If you get to use those, please
  include the change in the patch which use those.

* Stuff remaining to be done
  Show stoppers
      - reading proper signature value during probing
      - reading D2H FIS to determine proper stat/err values
      - less fragile command completion handling
  Others
      - 64bit enable
      - verify resetting and other code against hardware doc
      - (later) NCQ support
      - (later) hotplug support
      - (later) port multiplier support
      - (later) better error reporting
      - (maybe) multiple command queueing for non-NCQ drives

[ Start of patch descriptions ]

01_sil24_add-FIXME-comment.patch
	: add FIXME comment above ata_device_add

	Add FIXME comment above ata_device_add.

02_sil24_remove-irq-disable-on-spurious-intr.patch
	: remove irq disable code on spurious interrupt

	If interrupt occurs on a disabled port, the driver used to
        mask the port's interrupt, but we don't know if such action is
        necessary yet and that's not what other drives do.  So, just
        do nothing and tell IRQ subsystem that it's not our interrupt.

03_sil24_add-pci-fault-check.patch
	: add testing for PCI fault

	On entry to interrupt handler, PORT_SLOT_STAT register is read
        first.  Check if PCI fault or device removal has occurred by
        testing the value for 0xffffffff.

04_sil24_add-error_intr-function.patch
	: move error handling out of hot interrupt path

	Move error handling from sil24_host_intr into separate
        function - sil24_error_intr.

05_sil24_remove-PORT_TF.patch
	: remove PORT_TF

	Remove PORT_TF, as taskfile isn't located at PORT_TF.

06_sil24_remove-pp-port.patch
	: replace pp->port w/ ap->ioaddr.cmd_addr

	As ap->ioaddr.cmd_addr isn't used for PORT_TF anymore, replace
	pp->port w/ it as AHCI does.

07_sil24_fix-PORT_CTRL_STAT-constants.patch
	: fix PORT_CTRL_STAT constants

	PORT_CTRL_STAT constants were copied incorrectly from the
	preview driver.

	Signed-off-by: Edward Falk

08_sil24_add-comments-for-constants.patch
	: add more comments for constants

	Add more comments to constants.

	Signed-off-by: Edward Falk

[ End of patch descriptions ]

 Thanks.

--
tejun
