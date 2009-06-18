From: Tejun Heo <tj@kernel.org>
Subject: Re: ata_piix module SATA failure not only after pm-suspend resume
Date: Thu, 18 Jun 2009 21:47:55 +0900
Message-ID: <4A3A377B.7050506@kernel.org>
References: <1244701045.4142.8.camel@crystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50534 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758281AbZFRMqH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Jun 2009 08:46:07 -0400
In-Reply-To: <1244701045.4142.8.camel@crystal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: discord@u.washington.edu
Cc: linux-ide@vger.kernel.org

Colin Williams wrote:
> This bug goes back quite some time. Can anybody comment on it?
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/350711
> 
> older report:
> https://bugzilla.redhat.com/show_bug.cgi?id=183138

The reset failure is normal on certain configurations.  It usually
means that the drive didn't finish spinning up during the first reset
attempt.  The next one will succeed and that's how it's expected to
work.  So, it looks like the problem needs to be triaged properly
first.

Thanks.

-- 
tejun
