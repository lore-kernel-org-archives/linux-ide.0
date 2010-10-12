From: Tim Small <tim@seoss.co.uk>
Subject: Re: Sil 3124: "softreset failed (SRST command error)"
Date: Tue, 12 Oct 2010 16:42:24 +0100
Message-ID: <4CB481E0.4040705@seoss.co.uk>
References: <i8vbcg$4hc$1@dough.gmane.org> <i8vq15$biu$1@dough.gmane.org> <4CB4665F.5030207@kernel.org> <i91uv3$ooj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:38561 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932705Ab0JLPm2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2010 11:42:28 -0400
In-Reply-To: <i91uv3$ooj$1@dough.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Sanders <jeremy@jeremysanders.net>
Cc: linux-ide@vger.kernel.org

On 12/10/10 16:30, Jeremy Sanders wrote:
> I suppose it could be a broken card or an incompatibility with the
> motherboard.
>
>    

Bad PCI express to PCI-X bridge chip maybe, or maybe the Linux bug lies 
there?  I have seen cards with 2 3132s on instead (and a PCI express 
bridge), perhaps it'd be worth trying one of those?

Tim.


-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

