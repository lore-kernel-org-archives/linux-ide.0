From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SATA on SIS 965L
Date: Sat, 24 Sep 2005 11:58:00 +0200
Message-ID: <43352328.1040308@gmx.net>
References: <93F1C0D583283E4194E162A8D42ABFC607CBE2@grz-sbs-01.sms.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060603010100040009030602"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:25039 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932154AbVIXJ6D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Sep 2005 05:58:03 -0400
In-Reply-To: <93F1C0D583283E4194E162A8D42ABFC607CBE2@grz-sbs-01.sms.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mrvka <mmrvka@sms.at>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603010100040009030602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Martin,

please try the included patch against 2.6.13. Starting with 2.6.14-rc1
the support for SiS965L is included.


regards
Uwe Koziolek

Martin Mrvka schrieb:

> Hello Uwe,
>
> I'm writing since I'm at the end of my researches and I have no more
> clue how to solve the following problem.
>
> As I've read on certain discussion boards, there seems to be many
> people having problems with their SIS 965L chipset and linux in
> general (havn't heard of any distribution that works).
>
>
> The patch SIS is offering on their website for 2.6.10 is not working
> for newer kernels. And for some strange reason a 2.6.10 kernel from
> kernel.org does not compile on Suse OSS 10.
>
>
> Are there any plans to integrate the SIS 965L in libsata or could you
> help me to build a patch for the current 2.6.13 kernel from kernel.org?
>
> I've given up trying on the Suse kernels, since they use a different
> method to access the scatterlist and I'm not able to understand this
> at all.
>
>
> Many Thanks,
>
> Martin
>


--------------060603010100040009030602
Content-Type: application/gzip;
 name="sata_sis.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sata_sis.patch.gz"

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
--------------060603010100040009030602--
