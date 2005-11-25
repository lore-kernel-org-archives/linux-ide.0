From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Assorted bugs in the PIIX drivers
Date: Fri, 25 Nov 2005 14:53:36 +0000
Message-ID: <1132930416.3298.26.camel@localhost.localdomain>
References: <1132929808.3298.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:20133 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161081AbVKYOUg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Nov 2005 09:20:36 -0500
In-Reply-To: <1132929808.3298.18.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Gwe, 2005-11-25 at 14:43 +0000, Alan Cox wrote:
> I finally got all the documents rounded up to try and redo Jgarzik's
> PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)

Add another one - PPE is set unconditionally while the documentation
says it should be set for fixed disk only.

