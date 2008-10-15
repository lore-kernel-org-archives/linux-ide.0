From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Wed, 15 Oct 2008 10:58:36 +0900
Message-ID: <48F54E4C.1020704@kernel.org>
References: <48E48BF2.1010403@gmail.com> <48E71DBC.5090301@kernel.org> <48F47924.9040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48215 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbYJOCAO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 22:00:14 -0400
In-Reply-To: <48F47924.9040504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damazy <damazy@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Damazy wrote:
> Tejun Heo wrote:
> 
>> Please post full kernel log including the boot messages and error
>> messages.

The commands are either being timed out or aborted by the device.  Can
you post the result of "smartctl -a" of the drive?

-- 
tejun
