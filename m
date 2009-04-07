From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Wed, 8 Apr 2009 00:35:16 +0200
Message-ID: <200904080035.16457.bzolnier@gmail.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <200904072339.00224.bzolnier@gmail.com> <20090407221554.GA4527@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:8883 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbZDGWfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 18:35:47 -0400
In-Reply-To: <20090407221554.GA4527@linux.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

On Wednesday 08 April 2009 00:15:54 Matthew Wilcox wrote:
> On Tue, Apr 07, 2009 at 11:38:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > I would like to see this merged for -rc1 so I tried to put it altogether
> > and then integrate it over recent IDE and block changes...
> 
> You're missing 1/5 and 2/5.  This patch will crash horribly if you use
> it with a drive which supports TRIM.

Heh, I knew something was out of place...
