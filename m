From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.31-rc5 regression: hd don't show up
Date: Fri, 14 Aug 2009 18:17:52 +0900
Message-ID: <4A852BC0.1090404@kernel.org>
References: <h63737$b2a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45505 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbZHNJR7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Aug 2009 05:17:59 -0400
In-Reply-To: <h63737$b2a$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tim Blechmann wrote:
> hi all,
> 
> running 2.6.31-rc5 (7cb7beb31aa3d941833b6a6e553687422c31e4b6 to be
> exact), sometimes some hard disks don't show up.
> 
> after booting, my root hd (sda) is mounted to /, while two other hds
> (sdb/sdc) are mounted as a user. sda is always present, but the other
> two sometimes don't show up (i.e. they are not listed in /dev/disk/, nor
> to they have a /dev/sdX link). with 2.6.29 and 2.6.30, all three disks
> are reported correctly.

Can you please attach boot logs of a successful and a failed boot?

Thanks.

-- 
tejun
