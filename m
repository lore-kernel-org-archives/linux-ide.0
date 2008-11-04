From: Mark Lord <liml@rtr.ca>
Subject: Re: WD3200BEVT frequent head unload
Date: Tue, 04 Nov 2008 12:11:55 -0500
Message-ID: <4910825B.8020103@rtr.ca>
References: <39e8b4be0811031614s2c28352ao62a7e937bbf90cc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35395 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbYKDRLQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 12:11:16 -0500
In-Reply-To: <39e8b4be0811031614s2c28352ao62a7e937bbf90cc3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aleksei Kazantsev <ajk.xyz@gmail.com>
Cc: linux-ide@vger.kernel.org

Aleksei Kazantsev wrote:
> drive unloads the head up to 360 times per hour
..

> *	Advanced Power Management feature set
..

Presumably "hdparm -B255 /dev/sda" cures this ?



