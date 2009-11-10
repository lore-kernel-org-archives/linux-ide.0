From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Tue, 10 Nov 2009 16:51:24 +0100
Message-ID: <200911101651.24912.bzolnier@gmail.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com> <4AF8F363.3010806@rtr.ca>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756807AbZKJPwd@vger.kernel.org>
In-Reply-To: <4AF8F363.3010806@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Thiago Farina <tfransosi@gmail.com>, jgarzik@pobox.com, mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 10 November 2009 06:00:19 Mark Lord wrote:
> Thiago Farina wrote:
> > Use ARRAY_SIZE macro of kernel api instead.
> > 
> > Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> > ---
> >  drivers/ata/sata_mv.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 6f5093b..a8a7be0 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -2217,7 +2217,7 @@ static unsigned int mv_qc_issue_fis(struct ata_queued_cmd *qc)
> >  	int err = 0;
> >  
> >  	ata_tf_to_fis(&qc->tf, link->pmp, 1, (void *)fis);
> > -	err = mv_send_fis(ap, fis, sizeof(fis) / sizeof(fis[0]));
> > +	err = mv_send_fis(ap, fis, ARRAY_SIZE(fis));
> >  	if (err)
> >  		return err;
> >  
> ..
> 
> What's the point of this ?
> 
> There is no "hardcoded array size" there to begin with,
> and using that silly macro obscures the actual calculation.
> 
> So now, instead of being able to verify correctness at a glance,

I kindly disagree here.  ARRAY_SIZE makes code smaller and prevents
subtle bugs in the more complex situations once you learn to always
use it.

[ Using ARRAY_SIZE you no longer have to verify anything and person
  looking at the code (which not necessarily is the original author)
  immediately knows what was the author's intention. ]

> I have to go off and research some silly macro and verify that
> it does the right thing.

You did it already and the macro name is quite descriptive so you
may as well just ACK the patch now.. ;)

-- 
Bartlomiej Zolnierkiewicz
