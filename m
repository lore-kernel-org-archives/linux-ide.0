From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Merging ATA passthru
Date: Fri, 21 Oct 2005 21:58:33 +0200
Message-ID: <1129924714.2786.38.camel@laptopd505.fenrus.org>
References: <43593E0A.4070801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965143AbVJUT6l@vger.kernel.org>
In-Reply-To: <43593E0A.4070801@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, 2005-10-21 at 15:14 -0400, Jeff Garzik wrote:
> Folks,
> 
> Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
> the ATA passthru work upstream, once 2.6.14 is released.
> 
> Since there are still some reported problems that I haven't had time to 
> track down, I'm going to -- like ATAPI -- introduce a module option that 
> enables passthru.  It will default to off.
> 
> Other features that follow a similar pattern -- 98% there but needs a 
> few final tweaks -- will be treated in the same way.

can you get a patch into -mm that default-on's them? That way the brave
of heart get it automatic while those who play safe get them
default-off. Expands your testingbase as well ;)
