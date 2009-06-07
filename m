From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Sun, 7 Jun 2009 20:54:01 +0100
Message-ID: <20090607205401.73556585@lxorguk.ukuu.org.uk>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	<4A2BF785.3020402@gmail.com>
	<c5bd819b0906071124j21270574h44db963bdc0b552d@mail.gmail.com>
	<200906071346.28021.lkml@morethan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755845AbZFGTx6@vger.kernel.org>
In-Reply-To: <200906071346.28021.lkml@morethan.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml@morethan.org
Cc: Grozdan <neutrino8@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

> The article presumes the simple case of a single commit being the
> problem.  If the problem involves more than one. . .
> 
> Think of doing a binary search in a list of values with duplicate
> entries.  ;)

My first guess is its whatever starting putting devices in D3 rudely
around 2.6.28/29. Someone needs to pin that down anyway and fix it.
