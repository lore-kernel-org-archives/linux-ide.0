From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 13/29] ide: use time_after() macro
Date: Thu, 3 Feb 2005 02:07:56 +0100
Message-ID: <58cb370e05020217075ae130a7@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025649.GN621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050202025649.GN621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:56:49 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 13_ide_tape_time_after.patch
> >
> >       Explicit jiffy comparision converted to time_after() macro.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
