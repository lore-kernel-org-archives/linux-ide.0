From: Dongjun Shin <djshin90@gmail.com>
Subject: Re: Data Recovery from SSDs - Impact of trim?
Date: Fri, 23 Jan 2009 08:40:48 +0900
Message-ID: <7fe698080901221540k46d72778rbbe47dcbb30b5614@mail.gmail.com>
References: <16517792.86041231719671929.JavaMail.weblogic@epml02>
	 <87f94c370901210756q532f69f8v605f6c45c07b1290@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:14930 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbZAVXku (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 18:40:50 -0500
Received: by ti-out-0910.google.com with SMTP id b6so3127026tic.23
        for <linux-ide@vger.kernel.org>; Thu, 22 Jan 2009 15:40:48 -0800 (PST)
In-Reply-To: <87f94c370901210756q532f69f8v605f6c45c07b1290@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@norcrossgroup.com>
Cc: d.j.shin@samsung.com, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Jan 22, 2009 at 12:56 AM, Greg Freemyer
<greg.freemyer@norcrossgroup.com> wrote:
>
> Dongjun,
>
> I just read the T13/e08137r2 draft you linked to and the powerpoint
> which addresses security issues caused by the 2007 proposed specs
> implementations.
>
> I'm very concerned not with the discarded sectors, but with the fact
> that I see no way to know which sectors hold valid / reliable data vs.
> those that have been discarded and thus hold unreliable data.
>
> The T13/e08137r2 draft It is not strong enough to address this issue
> in my opinion.
>
> == Details
>
> As I understand it there is no way for a OS / kernel / etc. to know
> whether a given sector on a SSD contains reliable data or not.  And
> even for SSDs that provide "deterministic" data in response to sector
> reads, the data itself could have been randomly modified/corrupted by
> the SSD, but the data returned regardless with no indication from the
> SSD that it is not the original data associated with that sector.
>
> The spec merely says that once a determistic SSD has a sector read,
> all subsequent sector reads from that sector will provide the same
> data.  That does not prevent the SSD from randomly modifying the
> discarded sectors prior to the first read.
>
> Lacking any specific indication from the SSD that data read from it is
> reliable vs. junk seems to make it unusable for many needs.  ie. I am
> talking about all sectors here, not just the discarded ones.  The
> kernel can't tell the difference between them anyway.
>
> In particular I am very concerned about using a SSD to hold data that
> would eventually be used in a court of law.  How could I testify that
> the data retrieved from the SSD is the same as the data written to the
> SSD since per the spec. the SSD does not even have a way to
> communicate the validity of data back to the kernel.
>
> I would far prefer that reads from "discarded" sectors be flagged in
> some way.  Then tools, kernels, etc. could be modified to check the
> flag and only depend on sector data retrieved from the SSD that is
> flagged reliable.  Or inversely, not tagged unreliable.
>

(I've changed my e-mail to gmail, sorry)

The "flagging" may make the situation complex.
For example, a read request may span over valid and invalid area.
(invalid means it's discarded and the original data is destroyed)

-- 
Dongjun
