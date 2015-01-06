From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v1 0/2] Add the PMP support for APM X-Gene SoC AHCI SATA
 Host Controller driver.
Date: Tue, 6 Jan 2015 19:06:53 +0530
Message-ID: <CAOHikRBs=tH+MTPTmhDkEpV67grLWJK+6a-i8qeMyx_dJ9oyeA@mail.gmail.com>
References: <1420538536-32165-1-git-send-email-stripathi@apm.com>
	<20150106125252.GB3077@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20150106125252.GB3077@htj.dyndns.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Linux SCSI List <linux-scsi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, patches@apm.com
List-Id: linux-ide@vger.kernel.org

Hi ,

On Tue, Jan 06, 2015 at 03:32:14PM +0530, Suman Tripathi wrote:
> This patch set implements the PMP support for APM X-Gene SoC AHCI SATA Host Controller driver.

Hmm... still doesn't apply to for-3.20 after pulling in
for-3.19-fixes.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.20

What am I doing wrong?

I just again cloned git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git

switched to remotes/origin/for-3.20

git apply 0001-ahci_xgene-Implement-the-xgene_ahci_poll_reg_val-to-.patch
git apply 0002-ahci_xgene-Implement-the-workaround-to-support-PMP-e.patch

Even tried with

patch -p1 < 0001-ahci_xgene-Implement-the-xgene_ahci_poll_reg_val-to-.patch
patch -p1 <  0002-ahci_xgene-Implement-the-workaround-to-support-PMP-e.patch

Both are working fine. Not sure what's wrong with your environment.

On Tue, Jan 6, 2015 at 6:22 PM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Jan 06, 2015 at 03:32:14PM +0530, Suman Tripathi wrote:
>> This patch set implements the PMP support for APM X-Gene SoC AHCI SATA Host Controller driver.
>
> Hmm... still doesn't apply to for-3.20 after pulling in
> for-3.19-fixes.
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.20
>
> What am I doing wrong?
>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

