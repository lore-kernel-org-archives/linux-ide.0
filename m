From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 8 May 2007 22:42:28 +1000 (EST)
Message-ID: <489861.65634.qm@web52605.mail.re2.yahoo.com>
References: <46405C24.9040603@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1561502638-1178628148=:65634"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52605.mail.re2.yahoo.com ([206.190.48.208]:20557 "HELO
	web52605.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934535AbXEHMm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:42:29 -0400
In-Reply-To: <46405C24.9040603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

--0-1561502638-1178628148=:65634
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Tejun Heo <htejun@gmail.com> wrote:

[...]

> Just in case, can you post the result of 'lspci -nntv'?

No worries. Here it is as an attachment.

Thanks

Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1561502638-1178628148=:65634
Content-Type: text/plain; name="lspci.txt"
Content-Description: 1699367306-lspci.txt
Content-Disposition: inline; filename="lspci.txt"

-[0000:00]-+-00.0  ATI Technologies Inc Unknown device [1002:7910]
           +-02.0-[0000:01]--+-00.0  ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] [1002:5b60]
           |                 \-00.1  ATI Technologies Inc RV370 [Radeon X300SE] [1002:5b70]
           +-07.0-[0000:02]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168]
           +-12.0  ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
           +-13.0  ATI Technologies Inc SB600 USB (OHCI0) [1002:4387]
           +-13.1  ATI Technologies Inc SB600 USB (OHCI1) [1002:4388]
           +-13.2  ATI Technologies Inc SB600 USB (OHCI2) [1002:4389]
           +-13.3  ATI Technologies Inc SB600 USB (OHCI3) [1002:438a]
           +-13.4  ATI Technologies Inc SB600 USB (OHCI4) [1002:438b]
           +-13.5  ATI Technologies Inc SB600 USB Controller (EHCI) [1002:4386]
           +-14.0  ATI Technologies Inc SB600 SMBus [1002:4385]
           +-14.1  ATI Technologies Inc SB600 IDE [1002:438c]
           +-14.2  ATI Technologies Inc SB600 Azalia [1002:4383]
           +-14.3  ATI Technologies Inc SB600 PCI to LPC Bridge [1002:438d]
           +-14.4-[0000:03]--
           +-18.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
           +-18.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
           +-18.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
           \-18.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]

--0-1561502638-1178628148=:65634--
