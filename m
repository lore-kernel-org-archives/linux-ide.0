From: Lieven Marchand <mal@wyrd.be>
Subject: Re:  timeouts with SiI 4726/3531
Date: Mon, 08 Oct 2007 20:58:22 +0200
Message-ID: <87lkadsab5.fsf@wyrd.be>
References: <87lkaf3moh.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213.219.155.205.adsl.dyn.edpnet.net ([213.219.155.205]:51457
	"EHLO black" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752356AbXJHTSl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Oct 2007 15:18:41 -0400
In-Reply-To: <87lkaf3moh.fsf@wyrd.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi,

I've solved the problem with the timeouts by disabling NCQ on the four
disks. Apparently there's something in the combination of NCQ+PMP that
gives problems.
