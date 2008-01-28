From: "Mike Zheng" <mail2mz@gmail.com>
Subject: Re: Marvel 88SE6121 driver
Date: Mon, 28 Jan 2008 11:49:07 -0500
Message-ID: <7f96c8390801280849n56a56d4aj3c36e889afdb1b03@mail.gmail.com>
References: <7f96c8390801280622w1edf1784p6144651d3233b8ca@mail.gmail.com>
	 <479DF016.7070100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:38660 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbYA1QtJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 11:49:09 -0500
Received: by el-out-1112.google.com with SMTP id v27so247149ele.23
        for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 08:49:08 -0800 (PST)
In-Reply-To: <479DF016.7070100@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: htejun@gmail.com, mlord@pobox.com, linux-ide@vger.kernel.org

Thanks Sergei. I tested with 0x0407. There is still no interrupt
generated from the controller. The following are the register values
after soft reset of the SATA port. Any idea for no interrupt from SATA
controller?

Thanks for your help,

Successfully done SATA_DoSoftReset loop = 1388
    ===>SATA Phy Regs on Port->Mmio_Base=0xe100dd00
            S-Status(0x0):  0x113
            S-Error(0x1):   0x4190000
            S-Control(0x2): 0x0
            PhyMode3(0x4):  0xaaa400ac
            PhyMode4(0x5):  0x48101cd
            PhyMode1(0xB):  0x402aa290
            PhyMode2(0xC):  0x392af
            TestControl(0xD):   0x80c000
            Loopback (0xF):   0x0
    ===>SATA Port Regs on Port->Mmio_Base=0xe100dd00
        CMD_BASE_L(0xe100dd00):     0x1ffe0000
        CMD_BASE_H(0xe100dd04):     0x0
        FIS_BASE_L(0xe100dd08):     0x1ffe0800
        FIS_BASE_H(0xe100dd0c):     0x0
        IRQ_STATUS(0xe100dd10):      0x0
        IRQ_Enable(0xe100dd14):      0xc0700039
        Command(0xe100dd18):      0x60001
        TF data(0xe100dd20):      0x110180
        Signature(0xe100dd24):      0x101
        SATA_STATUS(0xe100dd28):      0x113
        SATA_CNTL(0xe100dd2c):      0x0
        SATA_Err(0xe100dd30):      0x0
        SATA_Act(0xe100dd34):      0x0
        CMD_ISSUE(0xe100dd38):      0x0


On 1/28/08, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Mike Zheng wrote:
>
> > From PCI config space, the VENDOR_ID and DEVICE_ID are correct for my
> > driver. However the PCI_COMMAND register of 88SE6121 I got is 0x7,
> > which is the same as default value. Based on the document,  it has to
> > be 0x0207 to enable interrupt. However I always failed to do so, the
>
>    Bit 10 (mask 0x0200) is fast back-to-back enable, what does it have to do
> with iterrupts.
>
> > value remains 0x7 after it is re-assigned to the new value 0x0207. So
>
>    This means that fast back-to-back is not supported
>
> > that I have no interrupt from PCIe as INTA. Do you have any idea on
> > this issue?
>
>    There's also bit 11 (mask 0x0400) meaning INTx emulation *disable*.
>
> > Thanks for your help,
>
> > Mike Zheng
>
> MBR, Sergei
>
