From: David Miller <davem@davemloft.net>
Subject: Re: kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Date: Thu, 01 Oct 2009 01:30:30 -0700 (PDT)
Message-ID: <20091001.013030.98262804.davem@davemloft.net>
References: <20090930110529.GA3676@dis.manty.net>
	<20090930235709.43ff1255.akpm@linux-foundation.org>
	<200910011026.17510.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932352AbZJAIaR@vger.kernel.org>
In-Reply-To: <200910011026.17510.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: elendil@planet.nl
Cc: manty@manty.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Thu, 1 Oct 2009 10:26:14 +0200

> Question for IDE maintainers: should maybe the old printing of request info 
> be reinstated, or can the request flags also be obtained from the BUG 
> info?

Using a BUG for this doesn't make it any easier to track down the
problem.  WARN_ON_ONCE() or similar is much more appropriate here.

BUG() is for situations where the system's state is completely
irrecoverably corrupted, and we cannot continue, and that is not the
case here at all.
