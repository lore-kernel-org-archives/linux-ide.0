From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 08 Oct 2003 22:48:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1065649708.10565.23.camel@dhcp23.swansea.linux.org.uk>
References: <20030917144120.A11425@in.ibm.com>
	 <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk>
	 <20031008151357.A31976@in.ibm.com> <20031008115051.GD705@redhat.com>
	 <20031008174458.A32517@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20031008174458.A32517@in.ibm.com>
To: vatsa@in.ibm.com
Cc: Dave Jones <davej@redhat.com>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mer, 2003-10-08 at 13:14, Srivatsa Vaddagiri wrote:
> Since my code is supposed to run when system is crashing, I would like 
> to avoid calling any function in the kernel as far as possible, since 
> the kernel and its data structures may be in a inconsistent state 
> and/or corrupted.

For x86 udelay is a tiny piece of code - you could easily inline it
