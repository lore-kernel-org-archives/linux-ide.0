From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH 2/2] ide: remove obsolete CONFIG_BLK_DEV_ADMA - cleanup arch
Date: Wed, 15 Sep 2004 07:39:15 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040915053915.GA17465@rdrz.de>
References: <20040914095330.GF9994@rdrz.de> <20040914095847.GG9994@rdrz.de> <20040914180211.78b6085f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rdrz.de ([217.160.107.209]:33219 "HELO rdrz.de")
	by vger.kernel.org with SMTP id S267625AbUIOFjQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Sep 2004 01:39:16 -0400
Content-Disposition: inline
In-Reply-To: <20040914180211.78b6085f.akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 06:02:11PM -0700, Andrew Morton wrote:
> I don't see much point in applying global defconfig sweeps, really. 
> There's no end to it.
> 
> Obsolete paremeters do no real harm, and arch maintainers will
> automatically eliminate obsolete stuff when they do their next defconfig
> update.

Okey, I see the point. So Part 2/2 of this Patch is obsolete.

- Raphael
