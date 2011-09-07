From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC PATCH #upstream-fixes] libata: don't use 32bit PIO for
 small transfers
Date: Wed, 7 Sep 2011 11:41:36 +0100
Message-ID: <20110907114136.08db2464@bob.linux.org.uk>
References: <20110906042101.GE18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:32278 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350Ab1IGQT2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Sep 2011 12:19:28 -0400
In-Reply-To: <20110906042101.GE18425@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com, seth.heasley@intel.com

On Tue, 6 Sep 2011 13:21:01 +0900
Tejun Heo <tj@kernel.org> wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=40592

Bit more digging on this. Dug out other reports - the common link is
Sandybridge/Cougar Point chipsets & ATAPI in IDE mode.

Alan
