From: Greg Freemyer <greg.freemyer@norcrossgroup.com>
Subject: Re: Data Recovery from SSDs - Impact of trim?
Date: Wed, 21 Jan 2009 10:56:50 -0500
Message-ID: <87f94c370901210756q532f69f8v605f6c45c07b1290@mail.gmail.com>
References: <16517792.86041231719671929.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:55360 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbZAUP4x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2009 10:56:53 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1689914qwe.37
        for <linux-ide@vger.kernel.org>; Wed, 21 Jan 2009 07:56:51 -0800 (PST)
In-Reply-To: <16517792.86041231719671929.JavaMail.weblogic@epml02>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: d.j.shin@samsung.com
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Sun, Jan 11, 2009 at 7:21 PM, Dongjun Shin <d.j.shin@samsung.com> wrote:
> Greg,
>
> The short answer is "it's dependent on the manufacturer's implementation".
>
> The technical details are as follows.
>
> SSD translates the LBA from host into the physical address (flash block/page)
> using the mapping table which acts like the metadata of filesystem.
> For the recovery to work, both the mapping table of the original data _and_
> the physical data should be available.
>
> The trim command can invalidate the mapping only _or_ the mapping and
> the physical data as well. This is manufacturer-specific or sometimes
> requested as spec (ex. enterprise notebook where security is important).
> From the perspective of host, the trimmed are can be seen as (1) original data
> (2) all zero or 0xff (3) indeterminate.
>
> There are following discussion and proposal about the behavior of trim at T13.
> (named "deterministic read after trim")
>
> http://www.t10.org/ftp/t10/document.08/08-347r1.pdf
> http://www.t13.org/Documents/UploadedDocuments/docs2008/e08137r2-DRAT_-_Deterministic_Read_After_Trim.pdf
>
> However, this spec also does not meet your expectation because it does not
> guarantee the safety of the original data.
>
> Regards,
> Dongjun
>
> ------- Original Message -------
> Sender : Greg Freemyer<greg.freemyer@norcrossgroup.com>
> Date   : 2009-01-10 07:27 (GMT+09:00)
> Title  : Data Recovery from SSDs - Impact of trim?
>
> Dongjun (with linux-ide in copy),
>
> I got your name from a Linux Kernel posting and I was wondering if you
> could help me understand if data recovery will be possible with SSDs
> in the future.
>
> I work a lot with data recovery and forensic imaging.  With both,
> access to what the filesystem considers unallocated sectors / blocks /
> clusters is key to the process.  ie. A user deletes a file, but needs
> to restore it. Lots of recovery tools exist to assist in this, but
> obviously they need to be able to read the no longer allocated
> clusters.
>
> With a DISCARD enabled filesystem / kernel and with both current and
> future generation SSDs, I&#39;m curious if our tools are going to be able
> to read this information anymore.
>
> Per the proposed spec Tejun posted a link to a couple months ago, the
> response to a ATA read request of a trimmed sector can either be the
> original data or all zeros.
>
> http://t13.org/Documents/UploadedDocuments/docs2007/e07154r3-Data_Set_Management_Proposal_for_ATA-ACS2.pdf
>
> From my industries perspective we would very much like the original
> data to be returned as long as it is available.
>
> Can you provide any insight into how the manufacturers are planning to
> implement such reads?
>
> Thanks
> Greg

Dongjun,

I just read the T13/e08137r2 draft you linked to and the powerpoint
which addresses security issues caused by the 2007 proposed specs
implementations.

I'm very concerned not with the discarded sectors, but with the fact
that I see no way to know which sectors hold valid / reliable data vs.
those that have been discarded and thus hold unreliable data.

The T13/e08137r2 draft It is not strong enough to address this issue
in my opinion.

== Details

As I understand it there is no way for a OS / kernel / etc. to know
whether a given sector on a SSD contains reliable data or not.  And
even for SSDs that provide "deterministic" data in response to sector
reads, the data itself could have been randomly modified/corrupted by
the SSD, but the data returned regardless with no indication from the
SSD that it is not the original data associated with that sector.

The spec merely says that once a determistic SSD has a sector read,
all subsequent sector reads from that sector will provide the same
data.  That does not prevent the SSD from randomly modifying the
discarded sectors prior to the first read.

Lacking any specific indication from the SSD that data read from it is
reliable vs. junk seems to make it unusable for many needs.  ie. I am
talking about all sectors here, not just the discarded ones.  The
kernel can't tell the difference between them anyway.

In particular I am very concerned about using a SSD to hold data that
would eventually be used in a court of law.  How could I testify that
the data retrieved from the SSD is the same as the data written to the
SSD since per the spec. the SSD does not even have a way to
communicate the validity of data back to the kernel.

I would far prefer that reads from "discarded" sectors be flagged in
some way.  Then tools, kernels, etc. could be modified to check the
flag and only depend on sector data retrieved from the SSD that is
flagged reliable.  Or inversely, not tagged unreliable.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
