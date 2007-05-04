From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Fri, 04 May 2007 16:30:01 -0300
Message-ID: <463B89B9.8050104@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com> <463B74DB.8060509@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060100060206080600050208"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:50347 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423079AbXEDTaG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 15:30:06 -0400
Received: by wx-out-0506.google.com with SMTP id h31so843805wxd
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 12:30:06 -0700 (PDT)
In-Reply-To: <463B74DB.8060509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

This is a multi-part message in MIME format.
--------------060100060206080600050208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Well, making it work without pci=nomsi is the whole point here.  I dunno
> why this simple thing doesn't work.  Can you post the result of 'lspci
> -nn' so that we can see the numeric ID?
>   
I would really like to know the answer to that, but i'm hundred of miles 
away. Attached to this email is the output of  lspci -nn .

Maybe you have the wrong id of the pci bridge:



00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port 
[1002:5a34]

+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a3f, quirk_disable_msi); /* RS480 PCI bridge */



--------------060100060206080600050208
Content-Type: text/plain;
 name="lspci.nn.2.6.20.4-generic-with-pci-quirks-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.nn.2.6.20.4-generic-with-pci-quirks-patch"

00:00.0 Host bridge [0600]: ATI Technologies Inc RS480 Host Bridge [1002:5950] (rev 10)
00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port [1002:5a34]
00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
00:13.0 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI0) [1002:4387]
00:13.1 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI1) [1002:4388]
00:13.2 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI2) [1002:4389]
00:13.3 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI3) [1002:438a]
00:13.4 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI4) [1002:438b]
00:13.5 USB Controller [0c03]: ATI Technologies Inc SB600 USB Controller (EHCI) [1002:4386]
00:14.0 SMBus [0c05]: ATI Technologies Inc SB600 SMBus [1002:4385] (rev 13)
00:14.1 IDE interface [0101]: ATI Technologies Inc SB600 IDE [1002:438c]
00:14.2 Audio device [0403]: ATI Technologies Inc SB600 Azalia [1002:4383]
00:14.3 ISA bridge [0601]: ATI Technologies Inc SB600 PCI to LPC Bridge [1002:438d]
00:14.4 PCI bridge [0604]: ATI Technologies Inc SB600 PCI to PCI Bridge [1002:4384]
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]
01:00.0 VGA compatible controller [0300]: nVidia Corporation G71 [GeForce 7300 GS] [10de:01df] (rev a1)
02:06.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL-8110SC/8169SC Gigabit Ethernet [10ec:8167] (rev 10)

--------------060100060206080600050208--
