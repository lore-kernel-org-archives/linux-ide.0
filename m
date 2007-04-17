From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: improve AC_ERR_DEV handling for ->post_internal_cmd
Date: Tue, 17 Apr 2007 10:42:47 -0400
Message-ID: <4624DCE7.8010106@garzik.org>
References: <20070320062411.GE6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39621 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443AbXDQOmu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:42:50 -0400
In-Reply-To: <20070320062411.GE6152@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ->post_internal_cmd is simplified EH for internal commands.  Its
> primary mission is to stop the controller such that no rogue memory
> access or other activities occur after the internal command is
> released.  It may provide error diagnostics by setting qc->err_mask
> but this hasn't been a requirement.
> 
> To ignore SETXFER failure for CFA devices, libata needs to know
> whether a command was failed by the device or for any other reason.
> ie. internal command needs to get AC_ERR_DEV right.
> 
> This patch makes the following changes to AC_ERR_DEV handling and
> ->post_internal_cmd semantics to accomodate this need and simplify
> callback implementation.
> 
> 1. As long as the correct bits in the result TF registers are set,
>    there is no need to set AC_ERR_DEV explicitly.  libata EH core
>    takes care of that for both normal and internal commands.
> 
> 2. The only requirement for ->post_internal_cmd() is to put the
>    controller into quiescent state.  It needs not to set any err_mask.
> 
> 3. ata_exec_internal_sg() performs minimal error analysis such that
>    AC_ERR_DEV is automatically set as long as result_tf is filled
>    correctly.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


