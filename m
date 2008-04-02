From: Frans Pop <elendil@planet.nl>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 2 Apr 2008 15:27:18 +0200
Message-ID: <200804021527.19367.elendil@planet.nl>
References: <200804021524.27222.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml14.kpnxchange.com ([213.75.38.114]:20316 "EHLO
	hpsmtp-eml14.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756277AbYDBN1V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 09:27:21 -0400
In-Reply-To: <200804021524.27222.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wednesday 02 April 2008, Frans Pop wrote:
> We've received an installation report for Debian for an older system
> where no IDE driver gets loaded. The system does not have any IDE device
> listed in lspci. When ide-generic is modprobed manually, both the CD and
> hard disk work fine.

Forgot to mention that the kernel used was 2.6.22. A retry with 2.6.24 
should be possible if needed.
