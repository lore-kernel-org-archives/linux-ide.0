From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATA/133 Problems with multiple cards
Date: Thu, 21 Oct 2004 20:43:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <58cb370e041021114374bb749f@mail.gmail.com>
References: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org>
	 <200410201623.21321.hpj@urpla.net>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S270799AbUJUSwl@vger.kernel.org>
In-Reply-To: <200410201623.21321.hpj@urpla.net>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: James Stevenson <james@stev.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
List-Id: linux-ide@vger.kernel.org

On Wed, 20 Oct 2004 16:23:21 +0200, Hans-Peter Jansen <hpj@urpla.net> wrote:
 
> Hmm, I'm running 3 TX2/100 (even with different revisions) without
> big problems here:
> 
> 00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
> 00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
> 00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
 
lspci -xxx ?
