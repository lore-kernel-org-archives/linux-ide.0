From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: New CD/DVD reports 'Can Play Audio    NO'
Date: Sat, 4 Oct 2008 15:41:30 +0200
Message-ID: <20081004134130.GA17429@gollum.tnic>
References: <bjbMi-2A6-1@gated-at.bofh.it> <E1Km5HY-0001Yj-Gx@be1.7eggert.dyndns.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:27209 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbYJDNli (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 09:41:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1359655fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2008 06:41:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1Km5HY-0001Yj-Gx@be1.7eggert.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bodo Eggert <7eggert@gmx.de>
Cc: Nick Warne <nick@ukfsn.org>, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Sat, Oct 04, 2008 at 01:26:44PM +0200, Bodo Eggert wrote:
> Nick Warne <nick@ukfsn.org> wrote:
> 
> > Very strange issue.  I recently bought a new machine that came with a
> > CD/DVD burner.  All functions normally, except I cannot play audio CD.
> > 
> > Information:
> > 
> > Slackware 12.1 running latest stable kernel 2.6.26.5
> > 
> > The drive is:
> > 
> > Vendor                      : Optiarc
> > Model                       : DVD RW AD-7200A
> > Revision                    : 1.06
> > 
> > Now, I have another drive (I purchased last year) that could play audio
> > CD, so I installed that as master, and put the new drive as slave
> > (old->hda new->hdb).  The old(er) drive can and does play audio OK.
> > 
> > I see this in /proc/sys/dev/cdrom/info:
> 
> > Can play audio:         0       1
> 
> Same as
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/186664/comments/9
> 
> Please complain to the vendor, so he stops doing this bull*.
> 
> Signed-Off-By: Bodo Eggert
> X-Tested: Not at all
> 
> --- linux-2.6.26/drivers/ide/ide-cd.c.ori       2008-10-04 13:21:17.000000000 +0200
> +++ linux-2.6.26/drivers/ide/ide-cd.c   2008-10-04 13:22:15.000000000 +0200
> @@ -1842,6 +1842,7 @@ static const struct cd_list_entry ide_cd
>         { "MATSHITADVD-ROM SR-8176", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      },
>         { "MATSHITADVD-ROM SR-8174", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      },
>         { "Optiarc DVD RW AD-5200A", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      },
> +       { "Optiarc DVD RW AD-7200A", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      },
>         { NULL, NULL, 0 }
>  };

ACK, although I vehemently object all those driver bloating lists of model
names. I'll think of something better. In the meantime, Bodo do you care to redo
your patch according to Documentation/SubmittingPatches? E.g. it is missing a
comment, the Signed-off-by: misses an email address, etc.

Thanks.

-- 
Regards/Gruss,
    Boris.
