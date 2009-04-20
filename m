From: Tejun Heo <tj@kernel.org>
Subject: Re: Question about ALPM, HIPM and DIPM
Date: Mon, 20 Apr 2009 16:44:14 +0900
Message-ID: <49EC27CE.2010300@kernel.org>
References: <ff05f3d00904152003s1938f20crec86c6d62a2ef3bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53706 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753720AbZDTHoU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Apr 2009 03:44:20 -0400
In-Reply-To: <ff05f3d00904152003s1938f20crec86c6d62a2ef3bf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Shao <laface.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

Edward Shao wrote:
> Hi~folks,
> 
> I'm wondering about AHCI ALPM, SATA HIPM and DIPM.
> 
> * ALPM is HIPM for AHCI?

ALPM uses HIPM but there are other ways to achieve HIPM too (via
SControl).

> * If ALPM is enabled but SATA HDD does not support HIPM (only DIPM),
> ALPM is effective?

Nope.

-- 
tejun
