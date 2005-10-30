From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sat, 29 Oct 2005 23:28:10 -0300
Message-ID: <200510300228.j9U2SAd3031713@inti.inf.utfsm.cl>
References: <torvalds@osdl.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932761AbVJ3Gr0@vger.kernel.org>
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org>
   of "Sat, 29 Oct 2005 12:37:58 PDT." <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Sat, 29 Oct 2005, Jeff Garzik wrote:
> > 
> > Even so, it's easy, to I'll ask him to test 2.6.14, 2.6.14-git1, and
> > (tonight's upcoming) 2.6.14-git2 (with my latest pull included) to see if
> > anything breaks.
> 
> Side note: one of the downsides of the new "merge lots of stuff early in 
> the development series" approach is that the first few daily snapshots end 
> up being _huge_. 

How about doing it in several stages at the beginning? I.e., have -git1
after one set of patches (pulling in from somebody, etc), and so on?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
