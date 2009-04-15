From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: LSF Papers online?
Date: Wed, 15 Apr 2009 09:30:15 +0100
Message-ID: <20090415093015.0c124573@lxorguk.ukuu.org.uk>
References: <49E335BA.3020103@panasas.com>
	<200904141654.24067.bzolnier@gmail.com>
	<20090414175441.5ce1f59d@lxorguk.ukuu.org.uk>
	<200904150009.06539.bzolnier@gmail.com>
	<1239749357.3638.3.camel@mulgrave>
	<49E53AE6.4010803@gmail.com>
	<1239767906.15559.1.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1239767906.15559.1.camel@mulgrave>
Sender: linux-scsi-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Jonathan Corbet <corbet@lwn.net>, Boaz Harrosh <bharrosh@panasas.com>, Zach Brown <zach.brown@oracle.com>, Chris Mason <chris.mason@oracle.com>, Tejun Heo <tj@kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> The point is, it doesn't really matter what I say or believe, it matters
> what they do ... and they believe fat stacks impede the performance of
> their SSDs.

The 'fat' is higher up, as is being clearly shown now people are finally
looking at aspects of the performance problems introduced around 2.6.19
in the fs layers.
