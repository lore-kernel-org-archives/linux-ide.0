From: Chase Venters <chase.venters@clientec.com>
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Date: Sun, 22 Jan 2006 13:24:42 -0600
Message-ID: <200601221325.04897.chase.venters@clientec.com>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz> <1137956841.3328.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay02.pair.com ([209.68.5.16]:37389 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751186AbWAVTZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 14:25:07 -0500
In-Reply-To: <1137956841.3328.36.camel@laptopd505.fenrus.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 22 January 2006 13:06, Arjan van de Ven wrote:
> I see you also use vmware. The other person who reported this also uses
> vmware. Could you please repeat the test without BOTH the nvidia and
> vmware modules?

Arjan,	
	Forgot to mention as well... Anton Titov reported this problem, and after 
going over his boot-time dmesg again it appears he's not tainting his kernel 
at all.

Cheers,
Chase
