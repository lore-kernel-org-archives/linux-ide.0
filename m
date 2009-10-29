From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-tape: remove the BKL
Date: Thu, 29 Oct 2009 03:10:05 -0700 (PDT)
Message-ID: <20091029.031005.137251834.davem@davemloft.net>
References: <20091011102519.GA2641@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47475
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330AbZJ2KJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 06:09:41 -0400
In-Reply-To: <20091011102519.GA2641@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com
Cc: linux-ide@vger.kernel.org

From: Borislav Petkov <petkovbb@googlemail.com>
Date: Sun, 11 Oct 2009 12:25:19 +0200

> Replace the BKL calls in the chrdev_{open,release} interfaces with a
> simple sleeping mutex.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Applied to ide-next-2.6
