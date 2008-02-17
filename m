From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/12] ide: add ide-4drives host driver
Date: Sun, 17 Feb 2008 18:12:40 +0100
Message-ID: <200802171812.40724.bzolnier@gmail.com>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain> <20080216163911.10174.58246.sendpatchset@localhost.localdomain> <20080216092635.987f002f.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:57544 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbYBQRKf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 12:10:35 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1403998fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 09:10:34 -0800 (PST)
In-Reply-To: <20080216092635.987f002f.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 16 February 2008, Randy Dunlap wrote:

[...]

> > +You also need to use "probe" kernel paramater for ide-4drives driver
> 
>                                        parameter

thanks, fixed in "take 2"
