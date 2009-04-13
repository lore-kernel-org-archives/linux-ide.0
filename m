From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH] sata_mv: use new sata phy register settings for new
	devices
Date: Mon, 13 Apr 2009 10:26:23 +0300
Message-ID: <c70ff3ad0904130026r4aac1ef4le36175ecdfed581c@mail.gmail.com>
References: <20090411160809.GA10922@deprecation.cyrius.com>
	 <da824cf30904111502u50d8f55dj2d0414bb45a49a22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:58288 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZDMH0Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 03:26:25 -0400
Received: by fg-out-1718.google.com with SMTP id e12so605632fga.17
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2009 00:26:23 -0700 (PDT)
In-Reply-To: <da824cf30904111502u50d8f55dj2d0414bb45a49a22@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

> Any chance these magic numbers can be documented?
>
> No objection to this patch and I would prefer a follow on
> patch to document the bits if that's possible.
Grant,
    those bits control analog/electrical settings of the sata phy
module, the functional spec uses acronyms to name it, and without much
documentation for it.

saeed
