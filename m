From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Re: Intel SATA combined mode quirk broken for SCSI_SATA=m
Date: Sun, 16 Oct 2005 19:55:07 -0700
Message-ID: <200510161955.07362.jbarnes@virtuousgeek.org>
References: <200510161913.59622.jbarnes@virtuousgeek.org> <43531030.9000901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:30674 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932152AbVJQCzU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Oct 2005 22:55:20 -0400
In-Reply-To: <43531030.9000901@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sunday, October 16, 2005 7:45 pm, Jeff Garzik wrote:
> Actually... does the attached patch fix things for you?

Yeah, this one causes the quirk to be built in as well.  I guess we get to 
choose between Kconfig ugliness (if vs. depends) and #if defined(..._MODULE) 
ugliness.  Yuck.

Jesse
