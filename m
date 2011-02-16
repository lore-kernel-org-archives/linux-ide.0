From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] ide-cs: housekeeping
Date: Wed, 16 Feb 2011 08:29:02 +0100
Message-ID: <20110216072902.GA27847@comet.dominikbrodowski.net>
References: <201102071151.08396.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201102071151.08396.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 07, 2011 at 11:51:07AM +0100, Bartlomiej Zolnierkiewicz wrote:
> * remove needless includes
> * remove stale comments
> * remove struct ide_info_t
> * remove legacy dev_dbg() debugging
> * inline ide_{config,release}()
> 
> Compile-tested only.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net> [pcmcia parts]

Best,
	Dominik
