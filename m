From: Vedran Rodic <vedran@vodatel.hr>
Subject: Re: Detecting CDROM Eject key press
Date: Mon, 11 Oct 2004 12:08:23 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <pan.2004.10.11.10.08.23.808702@vodatel.hr>
References: <4163E7A2.9060402@vodatel.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:22949 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268766AbUJKKVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2004 06:21:43 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CGxJG-0007bl-00
	for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2004 12:21:42 +0200
Received: from gargamel.vodatel.hr ([217.14.208.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2004 12:21:42 +0200
Received: from vedran by gargamel.vodatel.hr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2004 12:21:42 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 06 Oct 2004 14:40:02 +0200, Vedran Rodic wrote:

> Can I detect that CDROM Eject key has been pressed when the cdrom is
> mounted and the CDROM door is locked?
> 

I guess this is impossible, and the only way to make the eject key react
every time is by disabling door locking.

Vedran

