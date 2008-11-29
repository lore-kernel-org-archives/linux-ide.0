From: Tejun Heo <tj@kernel.org>
Subject: Re: about TRIM/DISCARD support and barriers
Date: Sun, 30 Nov 2008 07:57:36 +0900
Message-ID: <4931C8E0.3080404@kernel.org>
References: <83CA05F64804AF43B8F733C4ABDFAA51022D04B0@mail1.bitband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47648 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbYK2W5P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Nov 2008 17:57:15 -0500
In-Reply-To: <83CA05F64804AF43B8F733C4ABDFAA51022D04B0@mail1.bitband.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raz Ben-Yehuda <razb@bitband.com>
Cc: linux-ide@vger.kernel.org

hello,

Raz Ben-Yehuda wrote:
> Tejun Hello
> Is there a WIKI for SSD disk in Linux?

Not that I know of.

> I want to understand what is the rational for the OS intervention. Why
> and when you discard, fsck changes, why and how IO scheduling is
> changed...

FTL (flash translation layer) in SSDs can do better job if the OS
tells it which area is unused so that the SSD can just drop or
overwrite those regions.

-- 
tejun
