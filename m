From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 03/29] ide: cleanup opti621
Date: Thu, 3 Feb 2005 01:05:23 +0100
Message-ID: <58cb370e05020216055ad338ed@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024538.GD621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050202024538.GD621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:45:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 03_ide_cleanup_opti621.patch
> >
> >       In drivers/ide/pci/opti612.[hc], init_setup_opt621() is
> >       declared, defined and referenced but never actullay used.
> >       Thie patch removes the function.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
