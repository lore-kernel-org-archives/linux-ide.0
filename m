From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Fri, 23 Oct 2009 07:31:13 -0700 (PDT)
Message-ID: <20091023.073113.221141776.davem@davemloft.net>
References: <20091021.174155.44894825.davem@davemloft.net>
	<200910221144.04471.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37553
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997AbZJWOau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 10:30:50 -0400
In-Reply-To: <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mpatocka@redhat.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, elendil@planet.nl

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 23 Oct 2009 10:29:16 -0400 (EDT)

> If we don't know why the chip corrupts data, we must treat it as always 
> corrupting data.

Completely agreed.
