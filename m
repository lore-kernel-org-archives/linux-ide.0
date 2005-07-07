From: Christoph Lameter <christoph@lameter.com>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 12:09:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507071208210.8200@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net>
 <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261812AbVGGTP3@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, 7 Jul 2005, Linus Torvalds wrote:

> Yes. Except that if hwif is NULL, we'll have other oopses since we access 
> that in other places.
> 
> Why _is_ hwif NULL anyway? That's another, unrelated thing, and should 
> probably have a separate check and an early return.

I was wondering about that one as well. Andi brought it up.
