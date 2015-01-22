From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Sata_inic 162x support is broken message
Date: Thu, 22 Jan 2015 20:52:40 +0000
Message-ID: <20150122205240.4375452c@lxorguk.ukuu.org.uk>
References: <54C01B6C.90507@centurylink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:55757 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbbAVUwx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2015 15:52:53 -0500
In-Reply-To: <54C01B6C.90507@centurylink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Nolde <richard.nolde@centurylink.net>
Cc: linux-ide@vger.kernel.org

On Wed, 21 Jan 2015 14:34:36 -0700
Richard Nolde <richard.nolde@centurylink.net> wrote:

> I've recently upgraded one of my older backup Linux boxes to Fedora 20 
> (I know that 21 is out already, but 20 is what I running on my 
> production box and I wanted to be able to fall back seamlessly). When I 
> did this, I started getting an error message about he sata_inic 162x 
> kernel module being borked. After tracing through various postings, it 

Some people see errors, most don't but we don't know why. So if your
system is fine then be happy (but keep backups ;-) ). It's the people who
get corruption who need to do diagnostics and for the kind of errors seen
its likely to be of the 'I've got a brand new SATA analyser' kind.

Alan
