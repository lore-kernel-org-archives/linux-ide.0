From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: Re: ata link not reset properly
Date: Sat, 26 Jun 2010 11:00:27 +0200
Message-ID: <4C25C1AB.8010105@odi.ch>
References: <4C223F8A.9030306@odi.ch> <4C224429.6010705@kernel.org> <4C224502.2040206@kernel.org> <4C2305A8.4070708@odi.ch> <4C24C903.1070705@kernel.org> <4C24EED2.4020300@odi.ch> <4C257CEE.2070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C257CEE.2070309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 26.06.2010 06:07, Robert Hancock wrote:
> PATA doesn't normally use hard-resets as a means of error recovery -
> that would mean hitting the RESET line, which I don't think most
> controllers can do on software command 

Alright, no worries. I'll try to address the problem from the hardware side
then: cables, drives, etc.

Thanks.
  Ortwin
