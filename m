From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata NCQ implementation questions
Date: Tue, 13 May 2008 17:40:21 +0900
Message-ID: <482953F5.1020503@gmail.com>
References: <18471.32504.953679.399689@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:64906 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985AbYEMIkb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2008 04:40:31 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3117082rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2008 01:40:30 -0700 (PDT)
In-Reply-To: <18471.32504.953679.399689@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Mikael Pettersson wrote:
> I've started working on NCQ support for sata_promise,
> and I have a few questions regarding NCQ and libata:

Great.

> 1. Can I rely not seeing any non-NCQ commands while there
>    are uncompleted NCQ commands on a port?
> 
>    I _believe_, from the comment at ata_std_qc_defer(), that
>    this is the case, but I'd like to get that confirmed.

Yes, you can rely on that.

> 2. Assuming NCQ and non-NCQ commands cannot be mixed, is there
>    a defined way to detect when a port transitions from non-NCQ
>    to NCQ mode and vice versa, or do I have to detect that myself?
> 
>    The mode affects the programming of the Promise SATA "sequence
>    counter control" registers.

There's no defined way.  You'll probably need to add ->last_protocol or 
->was_ncq in LLD private structure.

> 3. Is qc->tag defined (to zero for instance) for non-NCQ commands?
> 
>    For sata_promise NCQ I need to allocate packets and prds from
>    per-port pools indexed by tag. To handle non-NCQ commands it's
>    easiest to assume they map to tag 0, but the code to set a tag
>    conditionally based on qc->tf.protocol is a bit ugly.

For all non-NCQ, non-EH commands, the tag is fixed at 0.

> 4. What are these "internal commands" that map to ATA_TAG_INTERNAL?
>    Are they NCQ or not?
>    Does the existence of ATA_TAG_INTERNAL limit queue depth for NCQ?

Yeah, it reserves tag 31 for EH commands.  We might as well use tag 32 
for EH commands and let LLD map it to whatever tag it can use for EH 
commands but Jeff didn't like using all the tags as it makes 0xffffffff 
a valid status value.

Note that depending on LLD implementation, you might want to remap tag 
31 to different hardware tag.  sata_sil24 does this mainly because it 
made polled execution implementation easier.

Thanks.

-- 
tejun
