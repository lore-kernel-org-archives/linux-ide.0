From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH 3/3] ep93xx: Add IDE support to edb93xx boards
Date: Fri, 30 Mar 2012 10:32:25 +0200
Message-ID: <4F756F99.8090301@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <4F741B3F.4000507@metasoft.pl> <ADE657CA350FB648AAC2C43247A983F00206970255C3@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:59778 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759718Ab2C3Ick (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Mar 2012 04:32:40 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206970255C3@AUSP01VMBX24.collaborationhost.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2012-03-29 18:32, H Hartley Sweeten wrote:
>> +static int __init edb93xx_has_ide(void)
>> +{
>> +	/*
>> +	 * Although EDB9312 and EDB9315 do have IDE capability, they have
>> +	 * INTRQ line wired as pull-up, which makes using IDE interface
>> +	 * problematic.
>> +	 */
>> +	return machine_is_edb9315a();
> 
> Allow the driver to be loaded on the EDB9312 and EDB9315 but leave the comment.
> If a use of these boards wishes to use the IDE they could remove the pull-up and add
> a pull-down to their board.

Ok. Will do that.
