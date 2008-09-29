From: "George Spelvin" <linux@horizon.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Mon, 29 Sep 2008 00:08:11 -0400
Message-ID: <20080929040812.8784.qmail@science.horizon.com>
References: <20080920151712.10515.qmail@science.horizon.com>
 <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>
 <20080921001529.23400.qmail@science.horizon.com>
 <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com>
 <48DA0C8B.3000406@gmail.com>
 <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com>
 <20080925032437.6802.qmail@science.horizon.com>
 <48DCEC6D.1040305@gmail.com>
 <20080928210422.2578.qmail@science.horizon.com>
 <48E0112C.7010901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:15917 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750940AbYI2EIP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 00:08:15 -0400
In-Reply-To: <48E0112C.7010901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com, htejun@gmail.com
Cc: Shane.Huang@amd.com, mdnelson8@gmail.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, grundler@google.com

Tejun Heo <htejun@gmail.com> wrote:

> George Spelvin wrote:
>> Tejun Heo <htejun@gmail.com> wrote:
>>>> Q: Does the fact that I'm using the GART IOMMU mean that I'm not really using
>>>> using 64-bit DMA at all?
>>> Can you turn it off and see what happens?
>> 
>> I can if I can verify that every other bus-master PCI device in the
>> system can do 64-bit DMA.
>> 
>> Do you know how to check that?  I haven't found a file under /sys or
>> /proc that tells me what the DMA masks are of various system
>> drivers, but that doesn't mean that it doesn't exist.
>
> It doesn't really matter.  The kernel will bounce buffers as
> necessary.

Er, according to the docs I can find, that's iommu=soft, and still
doesn't guarantee 64-bit DMA.  I was thinking about using iommu=off,
which disables everything including bounce buffers, and thereby forces
64-bit DMA.

Um... actually, I just tried it, and when there's >4G of memory, the kernel
forces iommu=soft, and it works.  At least as far as e2fsck -n on every
file system (including a 1.7 TB RAID-5) can tell.

It still doesn't definitively tell me that a DMA to and from an address
>4G was done, but it's an awfully strong hint.  I was thinking of
inserting a debug message that logs every time the "highest DMA address
used" increases, than I can watch it to see for sure.

ATM I'm just recompiling the kernel from -rc6 to -rc7.

It's in single-user mode so I can't ssh over the boot messages, but
they definitely included "64bit" from ahci_print_info().

Speaking of anci_print_info(), sould something like the following be a good
thing?

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2e1a7cb..18137d2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2464,22 +2464,22 @@ static void ahci_print_info(struct ata_host *host)
 		"%s\n"
 		,
 
-		cap & (1 << 31) ? "64bit " : "",
-		cap & (1 << 30) ? "ncq " : "",
-		cap & (1 << 29) ? "sntf " : "",
-		cap & (1 << 28) ? "ilck " : "",
-		cap & (1 << 27) ? "stag " : "",
-		cap & (1 << 26) ? "pm " : "",
-		cap & (1 << 25) ? "led " : "",
-
-		cap & (1 << 24) ? "clo " : "",
-		cap & (1 << 19) ? "nz " : "",
-		cap & (1 << 18) ? "only " : "",
-		cap & (1 << 17) ? "pmp " : "",
-		cap & (1 << 15) ? "pio " : "",
-		cap & (1 << 14) ? "slum " : "",
-		cap & (1 << 13) ? "part " : "",
-		cap & (1 << 6) ? "ems ": ""
+		cap & HOST_CAP_64   ? "64bit " : "",
+		cap & HOST_CAP_NCQ  ? "ncq " : "",
+		cap & HOST_CAP_SNTF ? "sntf " : "",
+		cap & (1 << 28)     ? "ilck " : "",
+		cap & HOST_CAP_SSS  ? "stag " : "",
+		cap & HOST_CAP_ALPM ? "pm " : "",
+		cap & (1 << 25)     ? "led " : "",
+
+		cap & HOST_CAP_CLO  ? "clo " : "",
+		cap & (1 << 19)     ? "nz " : "",
+		cap & (1 << 18)     ? "only " : "",
+		cap & HOST_CAP_PMP  ? "pmp " : "",
+		cap & (1 << 15)     ? "pio " : "",
+		cap & HOST_CAP_SSC  ? "slum " : "",
+		cap & (1 << 13)     ? "part " : "",
+		cap & HOST_CAP_EMS  ? "ems ": ""
 		);
 }
 

