From: "Davidlohr Bueso A." <dbueso@linuxchile.cl>
Subject: Re: Problems with DMA enabling
Date: Thu, 18 Aug 2005 19:52:17 -0400
Message-ID: <1124409137.3593.0.camel@localhost>
References: <1124293208.3885.10.camel@localhost>
	 <1124294354.5948.18.camel@localhost.localdomain>
	 <1124299885.3851.7.camel@localhost>
	 <1124355661.8720.23.camel@localhost.localdomain>
Reply-To: dbueso@linuxchile.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pc-79-164-104-200.cm.vtr.net ([200.104.164.79]:15081 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932289AbVHRXyO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Aug 2005 19:54:14 -0400
In-Reply-To: <1124355661.8720.23.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

On Thu, 2005-08-18 at 11:01 +0200, Erik Slagter wrote:

> For this to work, you must disable (legacy) IDE altogether. It looks it
> has claimed the second port before libata can do it.

Worked like a charm, thanks!

Dave
