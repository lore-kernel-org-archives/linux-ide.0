From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Date: Thu, 3 Feb 2005 15:13:28 +0100
Message-ID: <58cb370e05020306132afcabf8@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025448.GL621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263200AbVBCONq@vger.kernel.org>
In-Reply-To: <20050202025448.GL621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 11_ide_drive_sleeping_fix.patch
> >
> >       ide_drive_t.sleeping field added.  0 in sleep field used to
> >       indicate inactive sleeping but because 0 is a valid jiffy
> >       value, though slim, there's a chance that something can go
> >       weird.  And while at it, explicit jiffy comparisons are
> >       converted to use time_{after|before} macros.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
