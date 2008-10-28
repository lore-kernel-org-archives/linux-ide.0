From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 4/4] libata: clean up the SFF code for coding style
Date: Tue, 28 Oct 2008 10:47:05 +0100
Message-ID: <87zlkprqzq.fsf@denkblock.local>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180903.7781.51521.stgit@localhost.localdomain>
	<874p34ska1.fsf@denkblock.local>
	<20081022170218.32122780@lxorguk.ukuu.org.uk>
	<48FFC6DE.7060605@garzik.org> <49066FAB.2080101@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:53103 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbYJ1Jr0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 05:47:26 -0400
In-Reply-To: <49066FAB.2080101@kernel.org> (Tejun Heo's message of "Tue, 28
	Oct 2008 10:49:31 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo <tj@kernel.org> wrote:
> Jeff Garzik wrote:
>> Alan Cox wrote:
>
>>>>>          if (ata_is_atapi(qc->tf.protocol) &&
>>>>> -            !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>>>>> +           !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>>>> Ditto.
>>>
>>> Its lining up the bracketing but hey I'm not fussed, just twiddling where
>>> checkpatch warned and the like.
>>>
>>>>> - err_out:
>>>>> +err_out:
>>>> Yes, I've wondered about these myself occasionally. Personally, I don't
>>>> insert a blank before those labels either and would be in favour of such
>>>> a change. But do we actually have a convention regarding this matter?
>>>
>>> CodingStyle chapter 7 which is of course overridable by Jeff ;)
>> 
>> libata style has always matched that:  labels go in column 1, without
>> any preceding whitespace.
>
> Heh... I am the one who is always putting in the extra space there,
> mainly because emacs dictates how I format my code. :-) I'll try to turn
> it off.

(defun my-c-mode-hook ()
  (if (and (buffer-file-name)
	   (string-match "/home/eo/source/kernel/" (buffer-file-name)))
      (c-set-style "linux")))
(add-hook 'c-mode-hook 'my-c-mode-hook)

works very nicely for me and it doesn't insert the extra blank in front
of labels either except for the situation where the code following the
label is at indentation level > 1.

Regards,

Elias
