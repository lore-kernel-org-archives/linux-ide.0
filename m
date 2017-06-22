From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] libata: prevent writes to read-only registers
Date: Thu, 22 Jun 2017 16:13:23 -0400
Message-ID: <20170622201323.GA9722@htj.duckdns.org>
References: <20170621232014.27790-1-opendmb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35007 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753261AbdFVUN0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jun 2017 16:13:26 -0400
Content-Disposition: inline
In-Reply-To: <20170621232014.27790-1-opendmb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Berger <opendmb@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 21, 2017 at 04:20:11PM -0700, Doug Berger wrote:
> Recent Broadcom SoCs allow for the trapping of write accesses to
> read-only registers. This is only useful if such accesses are
> exceptional, so it is desirable to prevent such accesses in normal
> operation. To that end, this set of commits proposes adding two
> flags to the libata core.
> 
> The first allows for a quirk that exists in some Broadcom devices
> that are capable of supporting Aggresive Link Power Management even
> though it is not reported by their read-only capability register.
> This removes a need for the Broadcom driver to write to it's
> read-only capability register.
> 
> The second is a notification to the libata-core that it should not
> write to any standard registers that are defined to be read-only.
> 
> The Broadcom driver is then modified to use these two general 
> purpose flags.

Applied 1-3 to libata/for-4.13.

Thanks.

-- 
tejun
