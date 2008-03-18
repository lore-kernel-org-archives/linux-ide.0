From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: ide_cd modifies hard_* members of request
Date: Tue, 18 Mar 2008 12:05:14 +0100
Message-ID: <9ea470500803180405h5ede15eaqa86515058a632e2b@mail.gmail.com>
References: <1205830486.7126.16.camel@nikanth-laptop.blr.novell.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:14829 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYCRLFP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 07:05:15 -0400
Received: by wf-out-1314.google.com with SMTP id 28so5915205wff.4
        for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2008 04:05:15 -0700 (PDT)
In-Reply-To: <1205830486.7126.16.camel@nikanth-laptop.blr.novell.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nikanth Karthikesan <knikanth@suse.de>
Cc: Jens Axboe <jens.axboe@oracle.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

(sorry, forgot to cc all)

On Tue, Mar 18, 2008 at 9:54 AM, Nikanth Karthikesan <knikanth@suse.de>=
 wrote:
> Hi
>
>  Despite the warning in blkdev.h, that members of struct request star=
ting
>  with hard_* are block layer internals, and no driver should touch th=
em,
>  the ide_cd driver seems to fiddle around with it.
>
>  Is this reqd, or can this be made to work without the need for this?
>
>  If this reqd, why not provide a helper function for that in block la=
yer
>  itself, may be, with a warning about usage?
>
>  Thanks
>  Nikanth Karthikesan

Hi,

the code pieces you're referring to are in there since at least the
first git import of the kernel source (i.e. 2005) aka long time so
Bart/Jens should know that...


--=20
Regards/Gru=DF,
Boris
