From: Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for HPT36x
Date: Mon, 7 May 2007 00:53:38 +0200
Message-ID: <20070506225338.GA28300@apps.cwi.nl>
References: <200705042318.37367.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751884AbXEFWxy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200705042318.37367.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, michal.kepien@poczta.onet.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, May 04, 2007 at 11:18:37PM +0400, Sergei Shtylyov wrote:
> HPT36x chip don't seem to have the channel enable bits,
> so prevent the IDE core from checking them...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Earlier this evening I reported that HPT366 was broken in 2.6.21.
I confirm that this fixes it for me.

Andries
