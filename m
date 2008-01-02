From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 1/3] ide: use MODULE_VERSION()
Date: Wed, 2 Jan 2008 16:40:16 -0600
Message-ID: <20080102224016.GA30155@auslistsprd01.us.dell.com>
References: <200801011840.38757.bzolnier@gmail.com> <1199241156.3300.55.camel@perihelion> <20080102044620.GB10762@auslistsprd01.us.dell.com> <200801022345.17529.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:14183 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbYABWk1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 17:40:27 -0500
Content-Disposition: inline
In-Reply-To: <200801022345.17529.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jon Masters <jonathan@jonmasters.org>, Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 02, 2008 at 11:45:17PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Unfortunately 'srcversion' is set only if MODULE_VERSION() is used... :(

or CONFIG_MODULE_SRCVERSION_ALL=y.  I see Fedora doesn't use that :-(
but Ubuntu, openSUSE do.

/me files a change request...

-- 
Matt Domsch
Linux Technology Strategist, Dell Office of the CTO
linux.dell.com & www.dell.com/linux
