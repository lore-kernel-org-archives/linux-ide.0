From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Tue, 6 Jan 2004 00:59:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200401060059.52833.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401051808.49010.bzolnier@elka.pw.edu.pl> <20040105225117.GA5841@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040105225117.GA5841@leto.cs.pocnet.net>
Content-Disposition: inline
To: Christophe Saout <christophe@saout.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 05 of January 2004 23:51, Christophe Saout wrote:
> Remember? Can bio be NULL somewhere? Or what do you mean? It's our
> scratchpad and ide_multwrite never puts a NULL bio on it.

After last sector of the whole transfer is processed ide_multwrite() will set
it to NULL.  Next IRQ is only ACK of previous datablock, no transfer happens.

> > Otherwise I patch is OK for me.
>
> Ok, take two.
>
> I also did legacy/pdc4030.c, it's more or less the same though I'm not
> able to test it.

Looks OK.

> @@ -333,14 +332,17 @@
>  			 *	we can end the original request.
>  			 */
>  			if (!rq->nr_sectors) {	/* all done? */
> +				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
>  				rq = hwgroup->rq;
>  				ide_end_request(drive, 1, rq->nr_sectors);
>  				return ide_stopped;
>  			}
>  		}
>  		/* the original code did this here (?) */
> +		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
>  		return ide_stopped;

Move it before the comment.

--bart
