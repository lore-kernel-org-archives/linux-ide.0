From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATA] Failed to set xfermode on LITE-ON LTR-48246S
Date: Tue, 06 Mar 2007 00:46:07 +0900
Message-ID: <45EC3B3F.7020509@gmail.com>
References: <Pine.LNX.4.64.0702041057090.8424@woody.linux-foundation.org> <20070227135838.GA4328@titan.lahn.de> <45EB9822.40300@gmail.com> <20070305103840.GA4381@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933548AbXCEPqK@vger.kernel.org>
In-Reply-To: <20070305103840.GA4381@titan.lahn.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Philipp Matthias Hahn wrote:
> On Mon, Mar 05, 2007 at 01:10:10PM +0900, Tejun Heo wrote:
>> Philipp Matthias Hahn wrote:
>>> As reported by John Williams and others like in
>>> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg03088.html
>>> I too have a problem with 2.6.20.1 using ata_piix not detecting the
>>> CD-ROM any more. Applying the patch from
>>> http://lkml.org/lkml/2007/2/12/24 did not help, but additionally
>>> applying
>>> http://readlist.com/lists/vger.kernel.org/linux-kernel/45/228948.html
>>> made it work. Here's the relevant extra debugging output:
>> * Did it work with previous kernels?
> 
> Previously I was using the old IDE modules just fine, it was only with
> 2.6.20 that I did the switch to libata and encountered the problem.
> 
>> * Does applying the attached patch over unpatched 2.6.20.1 fix the problem?
> 
> Yes, it seems to fix it. (testes on top of the first patch mentioned
> above, but witheout the second one.).
> If I should test it as the sole patche, just mail me again please.

Yeap, please test it on top of vanilla kernel to verify that the patch
proper fixes the problem.

Thanks.

-- 
tejun
